import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/data/repositories/location_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:collection/collection.dart';

final coreAlgorithmsProvider = Provider.autoDispose(
  (ref) => CoreAlgorithms(
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    locationRepo: ref.watch(locationRepositoryProvider),
    firestoreHelper: FirestoreHelper.instance,
  ),
);

class CoreAlgorithms {
  CoreAlgorithms({
    required this.googleMapsApiServices,
    required this.locationRepo,
    required this.firestoreHelper,
  });
  final GoogleMapsApiServices googleMapsApiServices;
  final LocationRepository locationRepo;
  final FirestoreHelper firestoreHelper;

  /// Gets compatible drivers from the [driverConfigsStream] (along with their
  /// corresponding realtime locations) based on the [riderConfig]
  ///
  /// Better alternative: Build this as a Cloud Function to avoid having to
  /// retrieve all active_drivers and filtering them in-app
  Stream<List<RouteConfig>> getCompatibleDrivers({
    required RouteConfig riderConfig,
    required Stream<List<RouteConfig>> driverConfigsStream,
    required Stream<List<Map<String, KapiotLocation>>> driverLocsStream,
  }) async* {
    // A stream of a rider's compatible drivers derived from the merged
    // drivers' configs stream (Firestore) and drivers' currentLoc stream (RTDB)
    final compatibleDriversStream = driverConfigsStream
        .combineLatest<List<Map<String, KapiotLocation>>, List<RouteConfig>>(
      driverLocsStream,
      (driverConfigs, driverLocs) async {
        final List<RouteConfig> compatibleDrivers = [];
        for (final driverConfig in driverConfigs) {
          // Obtain the current location of this driverConfig from the
          // driverLocs stream (if none found, return null)
          final driverCurrentLoc = driverLocs
              .singleWhereOrNull(
                  (map) => (map.keys.first == driverConfig.user.id))
              ?.values
              .first;

          await checkCompatibility(
            riderConfig: riderConfig,
            driverConfig: driverConfig,
            driverCurrentLoc: driverCurrentLoc,
            whenCompatible: () => compatibleDrivers.add(driverConfig),
            whenUnreachable: () => firestoreHelper.deleteData(
              // In case the rider has already hailed (requested) this driver
              // before becoming unreachable (has passed the rider, for instance),
              // this deletes any of this rider's pending requests to the driver
              // to avoid instances where the driver may erroneously accept
              // the unreachable rider (despite having compatible routes)
              path: FirestorePath.docActiveDriverRequest(
                driverConfig.user.id,
                riderConfig.user.id,
              ),
            ),
          );
        }
        return compatibleDrivers;
      },
    );

    // To avoid unnecessary rebuilds to listeners (eg. StreamBuilders), only
    // emit data that is not equal to the last one (directly returning
    // the stream above (compatibleDriversStream) emits data everytime
    // driverStartLoc stream has updates)
    List<RouteConfig> lastDataEmitted = [];
    Function isListsEqual = const ListEquality().equals;
    await for (final data in compatibleDriversStream) {
      if (!isListsEqual(lastDataEmitted, data)) {
        lastDataEmitted = data;
        yield data;
      }
    }
  }

  /// Returns true when [riderConfig] is compatible with [driverConfig]
  Future<bool> checkCompatibility({
    required RouteConfig riderConfig,
    required RouteConfig driverConfig,
    required KapiotLocation? driverCurrentLoc,
    void Function()? whenCompatible,
    void Function()? whenUnreachable,
  }) async {
    final utils = googleMapsApiServices.utils;
    final distFromDriverStartToRiderStart = utils.calculateDistance(
      pointA: driverConfig.startLocation,
      pointB: riderConfig.startLocation,
    );

    final distFromDriverStartToRiderEnd = utils.calculateDistance(
      pointA: driverConfig.startLocation,
      pointB: riderConfig.endLocation,
    );

    bool isGoingTheSameDirection =
        (distFromDriverStartToRiderStart < distFromDriverStartToRiderEnd);

    if (isGoingTheSameDirection) {
      driverConfig as ForDriver;
      final decodedRoute = await utils.decodeRoute(
        driverConfig.encodedRoute,
      );
      bool riderStartCompatible = await utils.isLocationAlongRoute(
        location: riderConfig.startLocation,
        decodedRoute: decodedRoute,
      );
      bool riderEndCompatible = await utils.isLocationAlongRoute(
        location: riderConfig.endLocation,
        decodedRoute: decodedRoute,
      );
      if (riderStartCompatible && riderEndCompatible) {
        if (driverCurrentLoc != null) {
          final distFromDriverStartToCurrent = utils.calculateDistance(
            pointA: driverConfig.startLocation,
            pointB: driverCurrentLoc,
          );
          bool driverHasPassedRider =
              distFromDriverStartToRiderStart < distFromDriverStartToCurrent;
          if (!driverHasPassedRider) {
            whenCompatible?.call();
            return true;
          } else {
            whenUnreachable?.call();
          }
        }
      }
    }
    return false;
  }

  List<StopPoint> sortStopPoints({
    required RouteConfig driverConfig,
    required List<StopPoint> stopPoints,
  }) {
    final gmapsUtils = googleMapsApiServices.utils;
    driverConfig as ForDriver;
    // Remap the [stopPoints] as a list of Maps containing the StopPoint itself,
    // and its distance from the startPoint. This allows sorting them along the
    // route based on how far they are from the driver's startLocation. Much
    // room for improvement but this'll do for now
    List<Map<String, dynamic>> stopPointMapList = stopPoints.map((stopPoint) {
      final distanceFromStart = gmapsUtils.calculateDistance(
        pointA: driverConfig.startLocation,
        pointB: stopPoint.stopLocation,
      );
      return {
        "stopPoint": stopPoint,
        "distance": distanceFromStart,
      };
    }).toList();

    // Sort according to distanceFromStart from least to greatest
    stopPointMapList.sort((a, b) => a["distance"].compareTo(b["distance"]));

    // Remap back to a List<StopPoint> and return
    return stopPointMapList
        .map((spMap) => spMap["stopPoint"] as StopPoint)
        .toList();
  }

  /// Calculates the points a driver gets from one rider given
  /// that rider's [riderConfig]
  Future<double> calculateDriverPointsFromRider(
    RouteConfig riderConfig,
  ) async {
    final distMatrix = googleMapsApiServices.distMatrix;
    riderConfig as ForRider;
    final distMatrixElement = await distMatrix.getDistMatrixElement(
      pointA: riderConfig.startLocation,
      pointB: riderConfig.endLocation,
    );
    // Estimated distance in meters
    final distance = distMatrixElement.distanceValue;
    // Estimated duration of travel in seconds
    final duration = distMatrixElement.durationValue;

    // Four (4) points per 300 meters traveled and another
    // two (2) points per 60 seconds of travel
    return (distance / 75) + (duration / 30);
  }
}

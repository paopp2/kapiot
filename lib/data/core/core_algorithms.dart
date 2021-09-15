import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/repositories/location_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

final coreAlgorithmsProvider = Provider.autoDispose(
  (ref) => CoreAlgorithms(
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    locationRepo: ref.watch(locationRepositoryProvider),
  ),
);

class CoreAlgorithms {
  CoreAlgorithms({
    required this.googleMapsApiServices,
    required this.locationRepo,
  });
  final GoogleMapsApiServices googleMapsApiServices;
  final LocationRepository locationRepo;

  /// Gets compatible drivers from the driverConfigs in [driverConfigsStream]
  /// (along with the drivers' realtime locations) based on the [riderConfig]
  ///
  /// Better alternative: Build this as a Cloud Function to avoid having to
  /// retrieve all active_drivers and filtering them in-app
  Stream<List<RouteConfig>> getCompatibleDrivers({
    required RouteConfig riderConfig,
    required Stream<List<RouteConfig>> driverConfigsStream,
  }) async* {
    riderConfig as ForRider;
    final utils = googleMapsApiServices.utils;

    await for (final driverConfigs in driverConfigsStream) {
      final List<RouteConfig> compatibleDrivers = [];
      // For each driverConfig, check if both the start and end locations of a
      // rider lie along the driverConfig's route
      for (final driverConfig in driverConfigs) {
        driverConfig as ForDriver;
        final decodedRoute = await utils.decodeRoute(driverConfig.encodedRoute);
        final driverStartLocation = KapiotLocation(
          lat: decodedRoute.first.latitude,
          lng: decodedRoute.first.longitude,
        );

        final distFromDriverStartToRiderStart = utils.calculateDistance(
          pointA: driverStartLocation,
          pointB: riderConfig.startLocation,
        );

        final distFromDriverStartToRiderEnd = utils.calculateDistance(
          pointA: driverStartLocation,
          pointB: riderConfig.endLocation,
        );

        bool isGoingTheSameDirection =
            (distFromDriverStartToRiderStart < distFromDriverStartToRiderEnd);

        if (isGoingTheSameDirection) {
          bool riderStartCompatible = await utils.isLocationAlongRoute(
            location: riderConfig.startLocation,
            decodedRoute: decodedRoute,
          );
          bool riderEndCompatible = await utils.isLocationAlongRoute(
            location: riderConfig.endLocation,
            decodedRoute: decodedRoute,
          );
          if (riderStartCompatible && riderEndCompatible) {
            compatibleDrivers.add(driverConfig);
          }
        }
      }
      yield compatibleDrivers;
    }
  }

  Future<List<StopPoint>> sortStopPoints({
    required RouteConfig driverConfig,
    required List<StopPoint> stopPoints,
  }) async {
    final gmapsUtils = googleMapsApiServices.utils;
    driverConfig as ForDriver;
    final decodedRoute =
        await gmapsUtils.decodeRoute(driverConfig.encodedRoute);
    final startPoint = KapiotLocation(
      lat: decodedRoute.first.latitude,
      lng: decodedRoute.first.longitude,
    );
    // Remap the [stopPoints] as a list of Maps containing the StopPoint itself,
    // and its distance from the startPoint. This allows sorting them along the
    // route based on how far they are from the startPoint. Much room for
    // improvement, I know, but it'll do for the moment
    List<Map<String, dynamic>> stopPointMapList = stopPoints.map((stopPoint) {
      final distanceFromStart = gmapsUtils.calculateDistance(
        pointA: startPoint,
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
}

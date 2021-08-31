import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

final coreAlgorithmsProvider = Provider.autoDispose(
  (ref) => CoreAlgorithms(
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class CoreAlgorithms {
  CoreAlgorithms({required this.googleMapsApiServices});
  final GoogleMapsApiServices googleMapsApiServices;

  /// Retrieves compatible drivers from [driverConfigs] based on the [riderConfig]
  ///
  /// Better alternative: Build this as a Cloud Function to avoid having to
  /// retrieve all active_drivers and filtering them in-app
  Future<List<RouteConfig>> getCompatibleDrivers({
    required RouteConfig riderConfig,
    required List<RouteConfig> driverConfigs,
  }) async {
    riderConfig as ForRider;
    List<RouteConfig> compatibleDrivers = [];
    final utils = googleMapsApiServices.utils;

    // For each driverConfig, check if both the start and end locations of a
    // rider lie along the driverConfig's route
    for (var driverConfig in driverConfigs) {
      driverConfig as ForDriver;
      bool riderStartCompatible = await utils.isLocationAlongRoute(
        location: riderConfig.startLocation,
        encodedRoute: driverConfig.encodedRoute,
      );
      bool riderEndCompatible = await utils.isLocationAlongRoute(
        location: riderConfig.endLocation,
        encodedRoute: driverConfig.encodedRoute,
      );
      if (riderStartCompatible && riderEndCompatible) {
        compatibleDrivers.add(driverConfig);
      }
    }
    return compatibleDrivers;
  }

  Future<List<StopPoint>> sortStopPoints({
    required RouteConfig driverConfig,
    required List<StopPoint> stopPoints,
  }) async {
    final utils = googleMapsApiServices.utils;
    driverConfig as ForDriver;
    final decodedRoute = await googleMapsApiServices.utils
        .decodeRoute(driverConfig.encodedRoute);
    final startPoint = KapiotLocation(
      lat: decodedRoute.first.latitude,
      lng: decodedRoute.first.longitude,
    );
    // Remap the [stopPoints] as a list of Maps containing the StopPoint itself,
    // and its distance from the startPoint. This allows sorting them along the
    // route based on how far they are from the startPoint. Much room for
    // improvement, I know, but it'll do for the moment
    List<Map<String, dynamic>> stopPointMapList = stopPoints.map((stopPoint) {
      final distanceFromStart = utils.calculateDistance(
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
        .map((map) => map["stopPoint"] as StopPoint)
        .toList();
  }
}

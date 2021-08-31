import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final coreAlgorithmsProvider = Provider.autoDispose(
  (ref) => CoreAlgorithms(
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class CoreAlgorithms {
  CoreAlgorithms({required this.googleMapsApiServices});
  final GoogleMapsApiServices googleMapsApiServices;

  Future<List<RouteConfig>> getCompatibleDrivers({
    required RouteConfig riderConfig,
    required List<RouteConfig> driverConfigs,
  }) async {
    riderConfig as ForRider;
    List<RouteConfig> compatibleDrivers = [];
    final utils = googleMapsApiServices.utils;
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
}

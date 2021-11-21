import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final requestDriversMapController = Provider.autoDispose(
  (ref) => RequestDriversMapController(
    read: ref.read,
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class RequestDriversMapController extends MapController {
  RequestDriversMapController({
    required Reader read,
    required GoogleMapsApiServices googleMapsApiServices,
    required this.locationService,
  }) : super(
          read: read,
          googleMapsApiServices: googleMapsApiServices,
        );
  final LocationService locationService;

  Future<void> initializeRequestDriversMap() async {
    // Use location set from the previous view to initialize new GoogleMap
    final locationFromPreviousView = read(startLocProvider)!;
    await super.initializeMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(
          locationFromPreviousView.lat,
          locationFromPreviousView.lng,
        ),
        zoom: 20,
      ),
      clearMap: true,
    );
  }

  Future<void> showSelectedDriverRoute(RouteConfig driverConfig) async {
    driverConfig as ForDriver;
    final driverEncodedRoute = driverConfig.encodedRoute;
    await showRouteFromEncoded(encodedRoute: driverEncodedRoute);
  }
}

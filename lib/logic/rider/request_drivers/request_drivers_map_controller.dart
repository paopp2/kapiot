import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/shared/map_controller.dart';

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

  @override
  Future<void> initializeMap() async {
    var driverStartLoc = read(startLocProvider).state;
    initialCameraPosition = CameraPosition(
      target: LatLng(driverStartLoc!.lat, driverStartLoc.lng),
      zoom: 20,
    );
    await super.initializeMap();
    resetMap();
    read(startLocProvider).state = driverStartLoc;
    addMarker(
      markerId: "start_location",
      location: driverStartLoc,
    );
  }
}

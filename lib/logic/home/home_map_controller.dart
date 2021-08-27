import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'home_view_state.dart';

const double latLngBoundsPadding = 50.0;

final homeMapController = Provider.autoDispose(
  (ref) => HomeMapController(
    read: ref.read,
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class HomeMapController extends MapController {
  HomeMapController({
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
    final currentLoc = await locationService.getLocation();
    initialCameraPosition = CameraPosition(
      target: LatLng(currentLoc.lat, currentLoc.lng),
      zoom: 20,
    );
    read(startLocProvider).state = currentLoc;
    clearMap();
    addMarker(
      markerId: "start_location",
      location: currentLoc,
    );
    super.initializeMap();
  }
}

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/shared/map_controller.dart';

final requestAcceptedMapController = Provider.autoDispose(
  (ref) => RequestAcceptedMapController(
    read: ref.read,
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class RequestAcceptedMapController extends MapController {
  RequestAcceptedMapController({
    required Reader read,
    required GoogleMapsApiServices googleMapsApiServices,
    required this.locationService,
  }) : super(
          read: read,
          googleMapsApiServices: googleMapsApiServices,
        );
  final LocationService locationService;

  Future<void> initializeRequestAcceptedMap() async {
    final locationFromPreviousView = read(startLocProvider).state!;
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
    // Re-add the marker for the startLocation after clearing map
    addMarker(
      markerId: "start_location",
      location: locationFromPreviousView,
    );
  }
}

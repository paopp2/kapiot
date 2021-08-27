import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';

const double latLngBoundsPadding = 50.0;

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

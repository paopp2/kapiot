import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';

const double latLngBoundsPadding = 50.0;

final requestDriversMapController = Provider.autoDispose(
  (ref) => RequestDriversMapController(
    read: ref.read,
    locationService: ref.watch(locationServiceProvider),
    gmapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class RequestDriversMapController extends MapController {
  RequestDriversMapController({
    required this.read,
    required this.locationService,
    required this.gmapsApiServices,
  }) : super(
          baseRead: read,
          googleMapsApiServices: gmapsApiServices,
        );
  final Reader read;
  final LocationService locationService;
  final GoogleMapsApiServices gmapsApiServices;

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

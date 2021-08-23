import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'home_view_state.dart';

class HomeMapController {
  HomeMapController({
    required this.read,
    required this.locationService,
    required this.googleMapsApiServices,
  });
  final Completer<GoogleMapController> _controller = Completer();
  final Reader read;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;
  late final CameraPosition initialCameraPosition;

  Future<void> initializeMap() async {
    final currentLoc = await locationService.getLocation();
    initialCameraPosition = CameraPosition(
      target: LatLng(currentLoc.lat, currentLoc.lng),
      zoom: 20,
    );
    read(startLocProvider).state = currentLoc;
    addMarker(
      markerId: "start_location",
      location: currentLoc,
    );
  }

  void onMapCreated(GoogleMapController gmapController) async {
    _controller.complete(gmapController);
  }

  Future<void> showRoute({
    required KapiotLocation start,
    required KapiotLocation end,
  }) async {
    GoogleMapController controller = await _controller.future;
    read(startEndMarkersProvider).state = {};
    addMarker(markerId: "start_location", location: start);
    addMarker(markerId: "end_location", location: end);
    final routeCoordinates = await googleMapsApiServices.directions
        .getRouteCoordinates(start: start, end: end);
    drawRouteOutline(routeCoordinates);
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        (start.lat <= end.lat)
            ? LatLngBounds(
                southwest: LatLng(start.lat, start.lng),
                northeast: LatLng(end.lat, end.lng),
              )
            : LatLngBounds(
                southwest: LatLng(end.lat, end.lng),
                northeast: LatLng(start.lat, start.lng),
              ),
        0,
      ),
    );
  }

  void drawRouteOutline(List<LatLng> routeCoordinates) {
    final polylines = read(polylinesProvider).state;
    Polyline polyline = Polyline(
      polylineId: const PolylineId("poly"),
      color: Colors.red,
      points: routeCoordinates,
    );
    polylines.add(polyline);
    read(polylinesProvider).state = polylines;
  }

  void addMarker({required String markerId, required KapiotLocation location}) {
    final markers = read(startEndMarkersProvider).state;
    markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: LatLng(location.lat, location.lng),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    read(startEndMarkersProvider).state = markers;
  }
}

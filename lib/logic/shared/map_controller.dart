import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

const double latLngBoundsPadding = 50.0;

final markersProvider = StateProvider<Set<Marker>>((ref) => {});

final polylinesProvider = StateProvider<Set<Polyline>>((ref) => {});

abstract class MapController {
  MapController({
    required this.read,
    required this.googleMapsApiServices,
  });
  final Reader read;
  final GoogleMapsApiServices googleMapsApiServices;
  final Completer<GoogleMapController> _tempController = Completer();
  late final GoogleMapController gmapController;
  late final CameraPosition initialCameraPosition;

  Future<void> initializeMap() async {
    gmapController = await _tempController.future;
  }

  void onMapCreated(GoogleMapController gmapController) async {
    _tempController.complete(gmapController);
  }

  void clearMap() {
    read(markersProvider).state = {};
    read(polylinesProvider).state = {};
  }

  Future<List<LatLng>> getRouteCoordinates({
    required KapiotLocation start,
    required KapiotLocation end,
  }) async {
    return await googleMapsApiServices.directions
        .getRouteCoordinates(start: start, end: end);
  }

  Future<void> showRoute({
    required KapiotLocation start,
    required KapiotLocation end,
    required List<LatLng> routeCoordinates,
  }) async {
    read(markersProvider).state = {};
    addMarker(markerId: "start_location", location: start);
    addMarker(markerId: "end_location", location: end);
    drawPolyLine(routeCoordinates);
    gmapController.animateCamera(
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
        latLngBoundsPadding,
      ),
    );
  }

  void drawPolyLine(List<LatLng> routeCoordinates) {
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
    final markers = read(markersProvider).state;
    markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: LatLng(location.lat, location.lng),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    read(markersProvider).state = markers;
  }
}
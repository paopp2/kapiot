import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

const double latLngBoundsPadding = 50.0;

final startLocProvider = StateProvider<KapiotLocation?>((ref) => null);

final endLocProvider = StateProvider<KapiotLocation?>((ref) => null);

final markersProvider = StateProvider<Set<Marker>>((ref) => {});

final polylinesProvider = StateProvider<Set<Polyline>>((ref) => {});

abstract class MapController {
  MapController({
    required this.read,
    required this.googleMapsApiServices,
  });
  final Reader read;
  final GoogleMapsApiServices googleMapsApiServices;
  late Completer<GoogleMapController> _tempController;
  late GoogleMapController gmapController;
  late CameraPosition initialCameraPosition;

  Future<void> initializeMap({
    required CameraPosition initialCameraPosition,
    bool clearMap = false,
  }) async {
    _tempController = Completer();
    this.initialCameraPosition = initialCameraPosition;
    gmapController = await _tempController.future;
    if (clearMap) {
      this.clearMap();
    }
  }

  Future<void> onMapCreated(GoogleMapController gmapController) async {
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

  Future<void> showRouteFromEncoded({required String encodedRoute}) async {
    final decodedRoute =
        await googleMapsApiServices.utils.decodeRoute(encodedRoute);
    read(markersProvider).state = {};
    final startLocation = KapiotLocation(
      lat: decodedRoute.first.latitude,
      lng: decodedRoute.first.longitude,
    );
    final endLocation = KapiotLocation(
      lat: decodedRoute.last.latitude,
      lng: decodedRoute.last.longitude,
    );
    setStartLocation(startLocation);
    setEndLocation(endLocation);
    addMarker(
      markerId: "start_location",
      location: startLocation,
    );
    addMarker(
      markerId: "end_location",
      location: endLocation,
    );
    drawPolyLine(decodedRoute);
    gmapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        (startLocation.lat <= endLocation.lat)
            ? LatLngBounds(
                southwest: LatLng(startLocation.lat, startLocation.lng),
                northeast: LatLng(endLocation.lat, endLocation.lng),
              )
            : LatLngBounds(
                southwest: LatLng(endLocation.lat, endLocation.lng),
                northeast: LatLng(startLocation.lat, startLocation.lng),
              ),
        latLngBoundsPadding,
      ),
    );
  }

  void drawPolyLine(List<LatLng> routeCoordinates) {
    read(polylinesProvider).state = {};
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

  void setStartLocation(KapiotLocation? startLocation) {
    read(startLocProvider).state = startLocation;
  }

  void setEndLocation(KapiotLocation? endLocation) {
    read(endLocProvider).state = endLocation;
  }

  void showRouteIfBothLocationsSet({
    Function(List<LatLng> routeCoordinates)? onRouteCalculated,
  }) async {
    final startLocation = read(startLocProvider).state;
    final endLocation = read(endLocProvider).state;
    if (startLocation != null && endLocation != null) {
      final routeCoordinates = await getRouteCoordinates(
        start: startLocation,
        end: endLocation,
      );
      showRoute(
        start: startLocation,
        end: endLocation,
        routeCoordinates: routeCoordinates,
      );
      if (onRouteCalculated != null) {
        onRouteCalculated(routeCoordinates);
      }
    }
  }

  /// Resets the shared map state
  static void reset(Reader read) {
    read(markersProvider).state = {};
    read(polylinesProvider).state = {};
    read(startLocProvider).state = null;
    read(endLocProvider).state = null;
  }
}

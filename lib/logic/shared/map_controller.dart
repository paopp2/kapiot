import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/constants/markers.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

const double latLngBoundsPadding = 150.0;

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
    required KapiotLocation startLocation,
    required KapiotLocation endLocation,
    required List<LatLng> routeCoordinates,
  }) async {
    addMarker(marker: Markers.startLoc, location: startLocation);
    addMarker(marker: Markers.endLoc, location: endLocation);
    drawPolyLine(routeCoordinates);

    animateToRoute(
      startLocation: startLocation,
      endLocation: endLocation,
    );
  }

  Future<void> showRouteFromEncoded({required String encodedRoute}) async {
    final decodedRoute = googleMapsApiServices.utils.decodeRoute(encodedRoute);
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
    addMarker(marker: Markers.startLoc, location: startLocation);
    addMarker(marker: Markers.endLoc, location: endLocation);
    drawPolyLine(decodedRoute);

    animateToRoute(
      startLocation: startLocation,
      endLocation: endLocation,
    );
  }

  Future<void> animateToLocation({
    required KapiotLocation location,
    Marker? marker,
  }) async {
    gmapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(location.lat, location.lng),
        zoom: 20,
      ),
    ));
    addMarker(marker: marker ?? Markers.currentUserLoc, location: location);
  }

  Future<void> animateToRoute({
    required KapiotLocation startLocation,
    required KapiotLocation endLocation,
  }) async {
    // Determine correct LatLngBounds for Google map camera animation
    double northEastLat, southWestLat;
    double northEastLng, southWestLng;

    if (startLocation.lat <= endLocation.lat) {
      southWestLat = startLocation.lat;
      northEastLat = endLocation.lat;
    } else {
      northEastLat = startLocation.lat;
      southWestLat = endLocation.lat;
    }

    if (startLocation.lng <= endLocation.lng) {
      southWestLng = startLocation.lng;
      northEastLng = endLocation.lng;
    } else {
      northEastLng = startLocation.lng;
      southWestLng = endLocation.lng;
    }

    gmapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(southWestLat, southWestLng),
          northeast: LatLng(northEastLat, northEastLng),
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

  void addMarker({
    required Marker marker,
    required KapiotLocation location,
  }) {
    final markers = read(markersProvider).state;
    markers.removeWhere((m) => (m.markerId == marker.markerId));
    markers.add(
      marker.copyWith(
        positionParam: LatLng(location.lat, location.lng),
      ),
    );
    read(markersProvider).state = markers;
  }

  void removeMarker(Marker marker) {
    final markers = read(markersProvider).state;
    markers.removeWhere((m) => (m.markerId == marker.markerId));
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
        startLocation: startLocation,
        endLocation: endLocation,
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

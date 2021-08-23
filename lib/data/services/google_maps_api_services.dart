import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gmaps;
import 'package:maps_toolkit/maps_toolkit.dart' as Utils;

// TODO: Exposed API key! Hide in production
const googleApiKey = "AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI";

final googleMapsApiServicesProvider = Provider.autoDispose(
  (ref) => GoogleMapsApiServices(
    places: PlacesService.instance,
    directions: DirectionsService.instance,
    utils: MapsUtils.instance,
  ),
);

class GoogleMapsApiServices {
  GoogleMapsApiServices({
    required this.places,
    required this.directions,
    required this.utils,
  });
  final PlacesService places;
  final DirectionsService directions;
  final MapsUtils utils;
}

class PlacesService {
  PlacesService._();
  static final instance = PlacesService._();

  Future<List<String?>> getAutocompleteSuggestions(String query) async {
    final googlePlace = GooglePlace(googleApiKey);
    final result = await googlePlace.autocomplete.get(query);
    final predictions = result?.predictions ?? [];
    return (predictions.isNotEmpty)
        ? predictions.map((p) => p.description).toList()
        : [];
  }
}

class DirectionsService {
  DirectionsService._();
  static final instance = DirectionsService._();
  final _polylinePoints = PolylinePoints();

  Future<List<Gmaps.LatLng>> getRouteCoordinates({
    required KapiotLocation start,
    required KapiotLocation end,
  }) async {
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(start.lat, start.lng),
      PointLatLng(end.lat, end.lng),
      travelMode: TravelMode.driving,
    );
    return result.points
        .map((p) => Gmaps.LatLng(p.latitude, p.longitude))
        .toList();
  }
}

class MapsUtils {
  MapsUtils._();
  static final instance = MapsUtils._();

  // Conversion is necessary as google_maps_flutter and maps_toolkit both
  // implement a LatLng class
  Future<String> encodeRoute(List<Gmaps.LatLng> routeCoordinates) async {
    final convertedLatLngList = routeCoordinates
        .map((c) => Utils.LatLng(c.latitude, c.longitude))
        .toList();
    final encodedRoute = Utils.PolygonUtil.encode(convertedLatLngList);
    return encodedRoute;
  }
}

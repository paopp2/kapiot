import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

// TODO: Exposed API key! Hide in production
const googleApiKey = "AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI";

final googleMapsApiServicesProvider = Provider.autoDispose(
  (ref) => GoogleMapsApiServices(
    places: PlacesService.instance,
    directions: DirectionsService.instance,
  ),
);

class GoogleMapsApiServices {
  GoogleMapsApiServices({
    required this.places,
    required this.directions,
  });
  final PlacesService places;
  final DirectionsService directions;
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

  Future<List<LatLng>> getRouteCoordinates({
    required KapiotLocation start,
    required KapiotLocation end,
  }) async {
    final polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(start.lat, start.lng),
      PointLatLng(end.lat, end.lng),
      travelMode: TravelMode.driving,
    );
    return result.points.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }
}

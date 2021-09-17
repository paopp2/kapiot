import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/dist_matrix_element/dist_matrix_element.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:maps_toolkit/maps_toolkit.dart' as utils;
import 'package:http/http.dart' as http;
import 'dart:math' show cos, sqrt, asin;

// TODO: Exposed API key! Hide in production
const googleApiKey = "AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI";

final googleMapsApiServicesProvider = Provider.autoDispose(
  (ref) => GoogleMapsApiServices(
    places: PlacesService.instance,
    directions: DirectionsService.instance,
    distMatrix: DistanceMatrixService.instance,
    utils: MapsUtils.instance,
  ),
);

class GoogleMapsApiServices {
  GoogleMapsApiServices({
    required this.places,
    required this.directions,
    required this.utils,
    required this.distMatrix,
  });
  final PlacesService places;
  final DirectionsService directions;
  final DistanceMatrixService distMatrix;
  final MapsUtils utils;
}

class PlacesService {
  PlacesService._();
  static final instance = PlacesService._();

  /// Returns a list of maps containing the "id" (placeId) of the suggestion
  /// and the "address" containing the description of the suggestion
  Future<List<Map<String, String?>>> getAutocompleteSuggestions(
      String query) async {
    if (query.isEmpty) return [];
    final googlePlace = GooglePlace(googleApiKey);
    final result = await googlePlace.autocomplete.get(query);
    final predictions = result?.predictions ?? [];
    return (predictions.isNotEmpty)
        ? predictions
            .map((p) => {
                  "id": p.placeId,
                  "address": p.description,
                })
            .toList()
        : [];
  }

  Future<KapiotLocation?> getLocFromPlaceId(String placeId) async {
    final googlePlace = GooglePlace(googleApiKey);
    final response = await googlePlace.details.get(placeId);
    final latitude = response?.result?.geometry?.location?.lat;
    final longitude = response?.result?.geometry?.location?.lng;
    if (latitude != null && longitude != null) {
      return KapiotLocation(
        lat: latitude,
        lng: longitude,
      );
    } else {
      return null;
    }
  }
}

class DirectionsService {
  DirectionsService._();
  static final instance = DirectionsService._();
  final _polylinePoints = PolylinePoints();

  Future<List<gmaps.LatLng>> getRouteCoordinates({
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
        .map((p) => gmaps.LatLng(p.latitude, p.longitude))
        .toList();
  }
}

class DistanceMatrixService {
  DistanceMatrixService._();
  static final instance = DistanceMatrixService._();

  Future<DistMatrixElement> getDistMatrixElement(
    KapiotLocation pointA,
    KapiotLocation pointB,
  ) async {
    final latPointA = pointA.lat;
    final lngPointA = pointA.lng;
    final latPointB = pointB.lat;
    final lngPointB = pointB.lng;

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$latPointB,$lngPointB&origins=$latPointA,$lngPointA&key=$googleApiKey");
    final result = await http.get(url);

    Map<String, dynamic> decodedResult = jsonDecode(result.body);

    final distanceText =
        decodedResult["rows"][0]["elements"][0]["distance"]["text"];
    final distanceValue =
        decodedResult["rows"][0]["elements"][0]["distance"]["value"];
    final durationText =
        decodedResult["rows"][0]["elements"][0]["duration"]["text"];
    final durationValue =
        decodedResult["rows"][0]["elements"][0]["duration"]["value"];

    return DistMatrixElement(
      distanceText: distanceText,
      distanceValue: distanceValue.toDouble(),
      durationText: durationText,
      durationValue: durationValue.toDouble(),
    );
  }
}

class MapsUtils {
  MapsUtils._();
  static final instance = MapsUtils._();

  // Conversion is necessary as google_maps_flutter and maps_toolkit both
  // implement a LatLng class
  Future<String> encodeRoute(List<gmaps.LatLng> routeCoordinates) async {
    final convertedLatLngList = routeCoordinates
        .map((c) => utils.LatLng(c.latitude, c.longitude))
        .toList();
    return utils.PolygonUtil.encode(convertedLatLngList);
  }

  // Same case with encodeRoute (why conversion is necessary)
  Future<List<gmaps.LatLng>> decodeRoute(String encodedRoute) async {
    final preConvertRouteCoordinates = utils.PolygonUtil.decode(encodedRoute);
    return preConvertRouteCoordinates
        .map((coor) => gmaps.LatLng(coor.latitude, coor.longitude))
        .toList();
  }

  Future<bool> isLocationAlongRoute({
    required KapiotLocation location,
    required List<gmaps.LatLng> decodedRoute,
  }) async {
    final convertedLocation = utils.LatLng(location.lat, location.lng);
    return utils.PolygonUtil.isLocationOnPath(
      convertedLocation,
      decodedRoute
          .map((gmapsLatLng) => utils.LatLng(
                gmapsLatLng.latitude,
                gmapsLatLng.longitude,
              ))
          .toList(),
      true,
      tolerance: 100,
    );
  }

  /// Calculates distance between two points using the Haversine formula and
  /// returns the result in km
  double calculateDistance({
    required KapiotLocation pointA,
    required KapiotLocation pointB,
  }) {
    final lat1 = pointA.lat;
    final lon1 = pointA.lng;
    final lat2 = pointB.lat;
    final lon2 = pointB.lng;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

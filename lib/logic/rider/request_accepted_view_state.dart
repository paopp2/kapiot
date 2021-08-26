import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final startLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

final endLocProvider = StateProvider.autoDispose<KapiotLocation?>((ref) {
  ref.maintainState = true;
  return null;
});

final startEndMarkersProvider =
    StateProvider.autoDispose<Set<Marker>>((ref) => {});

final polylinesProvider = StateProvider.autoDispose<Set<Polyline>>((ref) => {});

final routeCoordinatesProvider = StateProvider.autoDispose<List<LatLng>>((ref) {
  ref.maintainState = true;
  return [];
});

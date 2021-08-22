import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final cameraPositionProvider =
    StateProvider.autoDispose<CameraPosition?>((ref) => null);

final isRiderSelectedProvider = StateProvider.autoDispose<bool>((ref) => true);

final riderCountProvider = StateProvider.autoDispose<int>((ref) => 1);

final dateTimeProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

final isStartLocFocusedProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final isEndLocFocusedProvider = StateProvider.autoDispose<bool>((ref) => false);

final placeSuggestionsProvider =
    StateProvider.autoDispose<List<String?>>((ref) => []);

final startLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

final endLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);
// TODO: Refactor as one source and destination?
final startEndMarkersProvider =
    StateProvider.autoDispose<Set<Marker>>((ref) => {});

final polylinesProvider = StateProvider.autoDispose<Set<Polyline>>((ref) => {});

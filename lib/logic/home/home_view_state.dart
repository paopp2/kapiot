import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isRiderProvider = StateProvider.autoDispose<bool>((ref) => true);

final riderCountProvider = StateProvider.autoDispose<int>((ref) => 1);

final dateTimeProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

final placeSuggestionsProvider =
    StateProvider.autoDispose<List<String?>>((ref) => []);

final routeCoordinatesProvider = StateProvider.autoDispose<List<LatLng>?>(
  (ref) {
    ref.maintainState = true;
    return null;
  },
);

final isForStartLocProvider = StateProvider.autoDispose<bool>((ref) {
  ref.maintainState = true;
  return true;
});

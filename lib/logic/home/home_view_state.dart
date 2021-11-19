import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/model/car/car.dart';

final riderCountProvider = StateProvider.autoDispose<int>((ref) {
  return ref.watch(chosenCarProvider.notifier).state?.capacity ?? 1;
});

final dateTimeProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

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

final chosenCarProvider = StateProvider.autoDispose<Car?>((ref) {
  final defaultCar = ref
      .watch(currentUserInfoProvider)
      .data
      ?.value
      ?.driverInfo
      ?.registeredCars
      .first;
  return defaultCar;
});

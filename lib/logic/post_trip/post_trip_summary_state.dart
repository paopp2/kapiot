import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final ratingProvider = StateProvider.autoDispose<double>((ref) {
  ref.maintainState = true;
  return 5.0;
});

final pointsProvider = Provider.autoDispose<double>((ref) {
  final transaction = ref.watch(transactionProvider).state;
  Future.delayed(const Duration(milliseconds: 10))
      .then((_) => (ref.state = transaction.points!));
  return 0;
});

final distanceInKmProvider = Provider.autoDispose<double>((ref) {
  final transaction = ref.watch(transactionProvider).state;
  Future.delayed(
    const Duration(seconds: 2),
    () => (ref.state = transaction.distance!),
  );
  return 0;
});

final timeInMinsProvider = Provider.autoDispose<double>((ref) {
  final transaction = ref.watch(transactionProvider).state;
  final startTime = transaction.startTime!;
  final endTime = transaction.endTime!;
  // TODO: Change [inSeconds] to [inMinutes]
  final duration = endTime.difference(startTime).inSeconds;
  Future.delayed(
    const Duration(seconds: 2),
    () => (ref.state = duration.toDouble()),
  );
  return 0;
});

final totalPointsProvider = StateProvider.autoDispose<double>((ref) => 0);

final isDriverProvider = Provider.autoDispose<bool>((ref) {
  final currentRouteConfig = ref.watch(currentRouteConfigProvider).state;
  return (currentRouteConfig is ForDriver);
});

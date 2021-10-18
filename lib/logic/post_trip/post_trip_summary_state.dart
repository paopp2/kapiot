import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/model/driver_info/driver_info.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final pointsProvider = Provider.autoDispose<double>((ref) {
  final transaction = ref.watch(transactionProvider).state;
  Future.delayed(const Duration(milliseconds: 10))
      .then((_) => (ref.state = transaction.points!));
  return 0;
});

final ratingProvider = StateProvider.autoDispose<int>((ref) => 0);

final acceptingDriverInfoProvider =
    StateProvider.autoDispose<KapiotUserInfo?>((ref) => null);

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

// As currentUserInfo gets updated before totalPoints is shown to the user,
// totalPointsProvider listens to the currentUserInfoProvider and updates its
// internal state based from that
final totalPointsProvider = Provider.autoDispose<double>((ref) {
  final currentUserInfo = ref.watch(currentUserInfoProvider).data?.value;
  Future.delayed(
    const Duration(seconds: 2),
    () => (ref.state = currentUserInfo?.points ?? 0),
  );
  return 0;
});

final isDriverProvider = Provider.autoDispose<bool>((ref) {
  final currentRouteConfig = ref.watch(currentRouteConfigProvider).state;
  return (currentRouteConfig is ForDriver);
});

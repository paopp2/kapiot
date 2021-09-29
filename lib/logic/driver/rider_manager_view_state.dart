import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

final requestingRidersStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(riderManagerViewModel).getRequestingRidersStream(),
);

final driverPointsProvider = StateProvider.autoDispose<double>((ref) => 0);

final nextStopProvider = StateProvider.autoDispose<StopPoint?>((ref) {
  ref.maintainState = true;
  return null;
});

final stopPointsProvider = StateProvider.autoDispose<List<StopPoint>>((ref) {
  ref.maintainState = true;
  return [];
});

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

final riderManagerViewModel =
    Provider.autoDispose((ref) => RiderManagerViewModel(
          read: ref.read,
          driverRepo: ref.watch(driverRepositoryProvider),
          currentUser: ref.watch(currentUserProvider),
        ));

class RiderManagerViewModel extends ViewModel {
  RiderManagerViewModel({
    required Reader read,
    required this.driverRepo,
    required this.currentUser,
  }) : super(read);
  final DriverRepository driverRepo;
  final KapiotUser? currentUser;

  @override
  void dispose() {
    read(currentRouteConfigProvider).dispose();
  }

  Stream<List<KapiotUser>> getRequestingRidersStream() =>
      driverRepo.getRequestingRidersStream(currentUser!);

  Stream<List<StopPoint>> getStopPointsStream() =>
      driverRepo.getStopPointsStream(currentUser!);

  void acceptRider(String riderId) {
    final currentDriverConfig = read(currentRouteConfigProvider).state;
    assert(currentDriverConfig != null);
    driverRepo.acceptRider(
      riderId,
      currentDriverConfig!,
    );
  }

  void nextStopPoint(StopPoint currentStopPoint) {
    read(stopPointIndexProvider).state++;
  }
}


// if (!currentStopPoint.isPickUp) {
//   read(stopPointIndexProvider).state++;
// } else {
//   // delete rider from accepted
//   // reset index to 0
// }
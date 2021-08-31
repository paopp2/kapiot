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
  void initState() {
    final stopPointsStream = getStopPointsStream();
    stopPointsStream.listen((stopPointsList) {
      read(stopPointsProvider).state = stopPointsList;
      StopPoint? nextStop = read(nextStopProvider).state;

      if (stopPointsList.length > 1) {
        if (nextStop == null) {
          // Initialize
          read(currentStopProvider).state = stopPointsList.first;
          read(nextStopProvider).state = stopPointsList[1];
        } else {
          final currentStop = read(currentStopProvider).state;
          if (currentStop != null) {
            if (!currentStop.isPickUp) {
              read(currentStopProvider).state = nextStop;
              final currentIndex = stopPointsList.indexOf(nextStop);
              read(nextStopProvider).state = stopPointsList[currentIndex + 1];
            }
          }
        }
      } else if (stopPointsList.length == 1) {
        read(currentStopProvider).state = stopPointsList.first;
        read(nextStopProvider).state = null;
      } else {
        read(currentStopProvider).state = null;
        read(nextStopProvider).state = null;
      }
    });
  }

  @override
  void dispose() {
    read(currentRouteConfigProvider).dispose();
  }

  Stream<List<KapiotUser>> getRequestingRidersStream() =>
      driverRepo.getRequestingRidersStream(currentUser!);

  Stream<List<StopPoint>> getStopPointsStream() {
    final currentDriverConfig = read(currentRouteConfigProvider).state!;
    return driverRepo.getStopPointsStream(currentDriverConfig);
  }

  void acceptRider(String riderId) {
    final currentDriverConfig = read(currentRouteConfigProvider).state;
    assert(currentDriverConfig != null);
    driverRepo.acceptRider(
      riderId,
      currentDriverConfig!,
    );
  }

  void nextStop() {
    final stopPointsList = read(stopPointsProvider).state;
    final currentStop = read(currentStopProvider).state;
    final nextStop = read(nextStopProvider).state;
    assert(currentStop != null);
    if (currentStop!.isPickUp) {
      read(currentStopProvider).state = nextStop;
      if (nextStop != null) {
        final currentIndex = stopPointsList.indexOf(nextStop);
        if (stopPointsList.length > (currentIndex + 1)) {
          read(nextStopProvider).state = stopPointsList[currentIndex + 1];
        } else {
          read(nextStopProvider).state = null;
        }
      }
    } else {
      final currentDriverConfig = read(currentRouteConfigProvider).state;
      assert(currentDriverConfig != null);
      driverRepo.removeRiderFromAccepted(
        currentDriverConfig!.user.id,
        currentStop.rider.id,
      );
    }
  }
}

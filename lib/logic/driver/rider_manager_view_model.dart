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
  static final List<StopPoint> _finishedStopPoints = [];

  @override
  void initState() {
    final stopPointsStream = getStopPointsStream();
    stopPointsStream.listen((stopPointsList) {
      read(stopPointsProvider).state = stopPointsList;
      if (stopPointsList.isNotEmpty) {
        if (_finishedStopPoints.isEmpty) {
          read(nextStopProvider).state = stopPointsList.first;
        } else {
          int i = 0;
          StopPoint stop = stopPointsList[i];
          while (_finishedStopPoints.contains(stop)) {
            stop = stopPointsList[i++];
          }
          read(nextStopProvider).state = stop;
        }
      } else {
        _finishedStopPoints.clear();
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

  void updateNextStop() {
    final currentStop = read(nextStopProvider).state!;
    _finishedStopPoints.add(currentStop);
    if (currentStop.isPickUp) {
      final stopPointsList = read(stopPointsProvider).state;
      final currentIndex = stopPointsList.indexOf(currentStop);
      read(nextStopProvider).state = stopPointsList[currentIndex + 1];
    } else {
      final currentDriverConfig = read(currentRouteConfigProvider).state!;
      driverRepo.removeRiderFromAccepted(
        currentDriverConfig.user.id,
        currentStop.rider.id,
      );
    }
  }
}

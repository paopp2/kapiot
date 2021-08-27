import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final riderManagerViewModel =
    Provider.autoDispose((ref) => RiderManagerViewModel(
          read: ref.read,
          driverRepo: ref.watch(driverRepositoryProvider),
          riderRepo: ref.watch(riderRepositoryProvider),
          currentUser: ref.watch(currentUserProvider),
        ));

class RiderManagerViewModel extends ViewModel {
  RiderManagerViewModel({
    required Reader read,
    required this.driverRepo,
    required this.riderRepo,
    required this.currentUser,
  }) : super(read);
  final RiderRepository riderRepo;
  final DriverRepository driverRepo;
  final KapiotUser? currentUser;

  @override
  void dispose() {
    read(currentRouteConfigProvider).dispose();
  }

  Stream<List<KapiotUser>> getAcceptedRidersStream() =>
      driverRepo.getAcceptedRidersStream(currentUser!);

  Stream<List<KapiotUser>> getRequestingRidersStream() =>
      driverRepo.getRequestingRidersStream(currentUser!);

  void acceptRider(String riderId) {
    final currentDriverConfig = read(currentRouteConfigProvider).state;
    assert(currentDriverConfig != null);
    driverRepo.acceptRider(
      riderId,
      currentDriverConfig!,
    );
    riderRepo.deletePendingRequests(currentDriverConfig.user.id, riderId);
  }

  // *! Temporary list to maintain provider logic
  List<String> requestingRiders = [
    'Christian Gonzales',
    'Blithe Gonzales',
    'Charles Ausejo'
  ];
  // *! Temporary list to maintain provider logic. Pretend this is a model instead of a list
  List<List<String>> acceptedRidersStopPoints = [
    ["Angel", "10.342993", "123.932906"],
    ["Grace", "10.367631", "123.913818"],
  ];
}

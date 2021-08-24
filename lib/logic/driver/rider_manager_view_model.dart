import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final riderManagerViewModel =
    Provider.autoDispose((ref) => RiderManagerViewModel(
          read: ref.read,
          driverRepo: ref.watch(driverRepositoryProvider),
          currentUser: ref.watch(currentUserProvider),
        ));

class RiderManagerViewModel {
  RiderManagerViewModel({
    required this.read,
    required this.driverRepo,
    required this.currentUser,
  });
  final Reader read;
  final DriverRepository driverRepo;
  final KapiotUser? currentUser;

  void initState() {}

  Stream<List<KapiotUser>> getAcceptedRidersStream() =>
      driverRepo.getAcceptedRidersStream(currentUser!);

  Stream<List<KapiotUser>> getRequestingRidersStream() =>
      driverRepo.getRequestingRidersStream(currentUser!);

  void acceptRider(String riderId) {
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    assert(currentRouteConfig != null);
    driverRepo.acceptRider(
      riderId,
      currentRouteConfig!,
    );
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
  void dispose() {}
}

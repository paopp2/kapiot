import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final requestDriversViewModel = Provider.autoDispose(
  (ref) => RequestDriversViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
  ),
);

class RequestDriversViewModel {
  RequestDriversViewModel({
    required this.read,
    required this.riderRepo,
    required this.currentUser,
  });
  final Reader read;
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;

  void initState() {}

  void requestDriver(String driverId) {
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    assert(currentRouteConfig != null);
    riderRepo.requestDriver(
      driverId,
      currentRouteConfig!,
    );
  }

  Stream<List<KapiotUser>> getCompatibleDrivers() =>
      riderRepo.getCompatibleDrivers();

  void dispose() {}
}

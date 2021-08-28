import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

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

  void acceptRider(String riderId) {
    final currentDriverConfig = read(currentRouteConfigProvider).state;
    assert(currentDriverConfig != null);
    driverRepo.acceptRider(
      riderId,
      currentDriverConfig!,
    );
  }
}

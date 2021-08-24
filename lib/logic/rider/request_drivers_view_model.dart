// TODO: Verify provider name
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final requestDriversViewModelProvider =
    Provider.autoDispose((ref) => RequestDriversViewModel(
          read: ref.read,
          riderRepo: ref.watch(riderRepositoryProvider),
          currentUser: ref.watch(currentUserProvider),
        ));

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

  // TODO: When requesting for a driver, the driver ID must be known to add in designated collection of that driver

  Stream<List<KapiotUser>> getCompatibleDrivers() =>
      riderRepo.getCompatibleDrivers();

  void dispose() {}
}

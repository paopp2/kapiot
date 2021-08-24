// TODO: Verify provider name
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final requestAcceptedViewModelProvider =
    Provider.autoDispose((ref) => RequestAcceptedViewModel(
          read: ref.read,
          riderRepo: ref.watch(riderRepositoryProvider),
          currentUser: ref.watch(currentUserProvider),
        ));

class RequestAcceptedViewModel {
  RequestAcceptedViewModel({
    required this.read,
    required this.riderRepo,
    required this.currentUser,
  });
  final Reader read;
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;

  void initState() {}

  Stream<List<KapiotUser>> getCompatibleDrivers() =>
      riderRepo.getCompatibleDrivers(currentUser!);

  void dispose() {}
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final requestAcceptedViewModel =
    Provider.autoDispose((ref) => RequestAcceptedViewModel(
          read: ref.read,
          riderRepo: ref.watch(riderRepositoryProvider),
          currentUser: ref.watch(currentUserProvider),
        ));

class RequestAcceptedViewModel extends ViewModel {
  RequestAcceptedViewModel({
    required Reader read,
    required this.riderRepo,
    required this.currentUser,
  }) : super(read);
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;
}

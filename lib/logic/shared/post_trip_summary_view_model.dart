import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final postTripSummaryViewModel = Provider.autoDispose(
  (ref) => PostTripSummaryViewModel(
    read: ref.read,
    currentUser: ref.watch(currentUserProvider),
  ),
);

class PostTripSummaryViewModel extends ViewModel {
  PostTripSummaryViewModel({
    required Reader read,
    required this.currentUser,
  }) : super(read);
  final KapiotUser? currentUser;

  @override
  Future<void> initState() async {}

  @override
  void dispose() {}
}

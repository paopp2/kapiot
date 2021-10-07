import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/logic/user_info/edit_user_info_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final editUserInfoViewModel = Provider.autoDispose(
  (ref) => EditUserInfoViewModel(
    read: ref.read,
    currentUser: ref.watch(currentUserProvider),
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
  ),
);

class EditUserInfoViewModel extends ViewModel {
  EditUserInfoViewModel({
    required Reader read,
    required this.currentUser,
    required this.userInfoRepo,
  }) : super(read);
  final KapiotUser? currentUser;
  final UserInfoRepository userInfoRepo;

  @override
  void initState() {}

  void setUserType(UserType userType) {
    read(userTypeProvider).state = userType;
    print(read(userTypeProvider).state);
  }

  void updateUserInfo() {
    print(read(userTypeProvider).state);
    final updatedUser =
        currentUser!.copyWith(userType: read(userTypeProvider).state);
    print(updatedUser);
  }
}

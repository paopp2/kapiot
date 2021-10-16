import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';
import 'init_user_info_view_state.dart';

final initUserInfoViewModel = Provider.autoDispose(
  (ref) => InitUserInfoViewModel(
    read: ref.read,
    currentUser: ref.watch(currentUserProvider)!,
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
  ),
);

class InitUserInfoViewModel extends ViewModel {
  InitUserInfoViewModel({
    required Reader read,
    required this.currentUser,
    required this.userInfoRepo,
  }) : super(read);
  final KapiotUser currentUser;
  final UserInfoRepository userInfoRepo;
  final homeLocFocusNode = FocusNode();
  final schoolLocFocusNode = FocusNode();
  final tecHomeLoc = TextEditingController();
  final tecSchoolLoc = TextEditingController();

  @override
  void dispose() {
    homeLocFocusNode.dispose();
    schoolLocFocusNode.dispose();
  }

  void goToNextStep() => read(pageIndexProvider).state++;

  void openSavePlacePicker({required bool isForHome}) async {
    final appRouter = AppRouter.instance;
    final location = await appRouter.navigateTo(
      Routes.savePlacePicker,
      args: (isForHome) ? tecHomeLoc.text : tecSchoolLoc.text,
    ) as KapiotLocation;
    String label = 'Home';
    if (isForHome) {
      tecHomeLoc.text = location.address!;
      homeLocFocusNode.unfocus();
    } else {
      label = (read(userTypeProvider).state == UserType.student)
          ? 'School'
          : 'Work';
      tecSchoolLoc.text = location.address!;
      schoolLocFocusNode.unfocus();
    }
    read(savedLocationsProvider).state[label] = location;
  }

  void setUserType(UserType userType) {
    read(userTypeProvider).state = userType;
  }

  void updateUserInfo() {
    final userType = read(userTypeProvider).state;
    final userId = currentUser.id;
    final userInfo = KapiotUserInfo(
      points: 0,
      savedLocations: read(savedLocationsProvider).state,
      userType: userType,
    );
    userInfoRepo.pushUserInfo(userId: userId, userInfo: userInfo);
    AppRouter.instance.popView();
  }
}

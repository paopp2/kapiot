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

  void goToNextStep({Duration? after}) {
    (after == null)
        ? read(pageIndexProvider.notifier).state++
        : Future.delayed(after, () => read(pageIndexProvider.notifier).state++);
  }

  void openSavePlacePicker({required bool isForHome}) async {
    final appRouter = AppRouter.instance;
    final location = await appRouter.navigateTo(
      Routes.savePlacePicker,
      args: (isForHome)
          ? read(homeFieldTextProvider.notifier).state
          : read(nonHomeFieldTextProvider.notifier).state,
    ) as KapiotLocation?;
    String label = 'Home';
    if (isForHome) {
      read(homeFieldTextProvider.notifier).state = location?.address;
    } else {
      label = (read(userTypeProvider.notifier).state == UserType.student)
          ? 'School'
          : 'Work';
      read(nonHomeFieldTextProvider.notifier).state = location?.address;
    }
    if (location != null) {
      read(savedLocationsProvider.notifier).state[label] = location;
    }
  }

  void skipSavingLocations() {
    read(savedLocationsProvider.notifier).state = {};
  }

  void setUserType(UserType userType) {
    read(userTypeProvider.notifier).state = userType;
  }

  void updateUserInfo() {
    final userType = read(userTypeProvider);
    final userId = currentUser.id;
    final userInfo = KapiotUserInfo(
      points: 0,
      savedLocations: read(savedLocationsProvider),
      userType: userType,
    );
    userInfoRepo.pushUserInfo(userId: userId, userInfo: userInfo);
    goToNextStep();
    AppRouter.instance.popView();
  }
}

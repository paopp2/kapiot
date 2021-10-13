import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/shared/place_suggester.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';
import 'package:kapiot/logic/shared/extensions.dart';
import 'edit_user_info_state.dart';

final editUserInfoViewModel = Provider.autoDispose(
  (ref) => EditUserInfoViewModel(
    read: ref.read,
    currentUser: ref.watch(currentUserProvider)!,
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
    placeSuggester: ref.watch(placeSuggesterProvider),
  ),
);

class EditUserInfoViewModel extends ViewModel {
  EditUserInfoViewModel({
    required Reader read,
    required this.currentUser,
    required this.userInfoRepo,
    required this.placeSuggester,
  }) : super(read);
  final KapiotUser currentUser;
  final UserInfoRepository userInfoRepo;
  final PlaceSuggester placeSuggester;
  final homeLocFocusNode = FocusNode();
  final schoolLocFocusNode = FocusNode();
  final tecHomeLoc = TextEditingController();
  final tecSchoolLoc = TextEditingController();

  @override
  void initState() {
    homeLocFocusNode.requestFocus();
  }

  @override
  void dispose() {
    homeLocFocusNode.dispose();
    schoolLocFocusNode.dispose();
  }

  void goToNextStep() => read(pageIndexProvider).state++;

  void editPlaceAddress({required bool isForStartLoc}) {
    (isForStartLoc) ? tecHomeLoc.selectText() : tecSchoolLoc.selectText();
    read(isForHomeLocProvider).state = isForStartLoc;
  }

  Future<void> pickSuggestion({
    required String pickedSuggestion,
    required bool forStartLoc,
  }) async {
    final location = await placeSuggester.getLocation(pickedSuggestion);
    String label = 'Home';
    if (forStartLoc) {
      tecHomeLoc.text = pickedSuggestion;
      homeLocFocusNode.unfocus();
    } else {
      label = (read(userTypeProvider).state == UserType.student)
          ? 'School'
          : 'Work';
      tecSchoolLoc.text = pickedSuggestion;
      schoolLocFocusNode.unfocus();
    }
    read(savedLocationsProvider).state[label] = location!.copyWith(
      address: pickedSuggestion,
    );
    placeSuggester.clearSuggestions();
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

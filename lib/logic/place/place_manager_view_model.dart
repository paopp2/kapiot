import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/logic/place/place_manager_view_state.dart';
import 'package:kapiot/logic/place/place_suggester.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final placeManagerViewModel = Provider.autoDispose(
  (ref) => PlaceManagerViewModel(
    read: ref.read,
    placeSuggester: ref.watch(placeSuggesterProvider),
    currentUser: ref.watch(currentUserProvider)!,
    userInfoRepository: ref.watch(userInfoRepositoryProvider),
  ),
);

class PlaceManagerViewModel extends ViewModel {
  PlaceManagerViewModel({
    required Reader read,
    required this.placeSuggester,
    required this.currentUser,
    required this.userInfoRepository,
  }) : super(read);
  final PlaceSuggester placeSuggester;
  final KapiotUser currentUser;
  final UserInfoRepository userInfoRepository;
  final _appRouter = AppRouter.instance;

  void editSavedLocation(
    String savedLocLabel,
    KapiotLocation? savedLoc,
  ) {
    read(locationToSaveProvider.notifier).state = savedLoc;
    _appRouter.navigateTo(
      Routes.savePlaceView,
      args: savedLocLabel,
    );
  }

  Future<void> getLocationToSave() async {
    final locToSave = await _appRouter.navigateTo(
      Routes.savePlacePicker,
    );
    if (locToSave != null) {
      read(locationToSaveProvider.notifier).state = locToSave;
      _appRouter.navigateTo(Routes.savePlaceView);
    }
  }

  Future<void> editLocationToSave() async {
    final locToEdit = read(locationToSaveProvider);
    final newLocToSave = await _appRouter.navigateTo(
      Routes.savePlacePicker,
      args: locToEdit!.address!,
    );
    read(locationToSaveProvider.notifier).state = newLocToSave ?? locToEdit;
  }

  void saveLocation({required String label}) {
    final currentUserInfo = read(currentUserInfoProvider).asData!.value!;
    final currentSavedLocations = currentUserInfo.savedLocations;
    userInfoRepository.pushUserInfo(
      userId: currentUser.id,
      userInfo: currentUserInfo.copyWith(
        savedLocations: currentSavedLocations
          ..[label] = read(locationToSaveProvider)!,
      ),
    );
    _appRouter.popUntil(Routes.placeManagerView);
  }
}

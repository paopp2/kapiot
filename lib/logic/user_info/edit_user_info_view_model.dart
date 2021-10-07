import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/logic/user_info/edit_user_info_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';

final editUserInfoViewModel = Provider.autoDispose(
  (ref) => EditUserInfoViewModel(
    read: ref.read,
    currentUser: ref.watch(currentUserProvider)!,
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
  ),
);

class EditUserInfoViewModel extends ViewModel {
  EditUserInfoViewModel({
    required Reader read,
    required this.currentUser,
    required this.userInfoRepo,
    required this.googleMapsApiServices,
  }) : super(read);
  final KapiotUser currentUser;
  final UserInfoRepository userInfoRepo;
  final GoogleMapsApiServices googleMapsApiServices;
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

  /// Used to store all autocomplete suggestion Maps in order to obtain the "id"
  /// from "address"
  List<Map<String, String?>> _autocompleteSuggestionMaps = [];

  void editPlaceAddress({required bool isForStartLoc}) {
    if (isForStartLoc) {
      // Highlight all text within the startLoc TextField
      tecHomeLoc.selection = TextSelection(
        baseOffset: 0,
        extentOffset: tecHomeLoc.text.length,
      );
    } else {
      // Highlight all text within the endLoc TextField
      tecSchoolLoc.selection = TextSelection(
        baseOffset: 0,
        extentOffset: tecSchoolLoc.text.length,
      );
    }
    read(isForHomeLocProvider).state = isForStartLoc;
  }

  Future<void> pickSuggestion({
    required String pickedSuggestion,
    required bool forStartLoc,
  }) async {
    final pickedSuggestionMap = _autocompleteSuggestionMaps.firstWhere(
      (s) => s["address"] == pickedSuggestion,
    );
    final placeId = pickedSuggestionMap["id"] as String;
    final location =
        await googleMapsApiServices.places.getLocFromPlaceId(placeId);
    if (forStartLoc) {
      tecHomeLoc.text = pickedSuggestion;
      read(homeLocProvider).state = location?.copyWith(
        address: pickedSuggestion,
      );
      homeLocFocusNode.unfocus();
    } else {
      tecSchoolLoc.text = pickedSuggestion;
      read(schoolLocProvider).state = location?.copyWith(
        address: pickedSuggestion,
      );
      schoolLocFocusNode.unfocus();
    }

    read(placeSuggestionsProvider).state = [];
  }

  void updateSuggestions(String? value) async {
    final suggestions = await googleMapsApiServices.places
        .getAutocompleteSuggestions(value ?? '');
    _autocompleteSuggestionMaps = suggestions;
    read(placeSuggestionsProvider).state =
        suggestions.map((s) => s["address"]).toList();
  }

  List<String> splitAddress(String completeAddress) {
    final index = completeAddress.indexOf(",");
    if (index != -1) {
      return [
        completeAddress.substring(0, index).trim(),
        completeAddress.substring(index + 1).trim()
      ];
    } else {
      return [completeAddress, "Philippines"];
    }
  }

  void setUserType(UserType userType) {
    read(userTypeProvider).state = userType;
  }

  void goToNextStep() => read(pageIndexProvider).state++;

  void updateUserInfo() {
    final userType = read(userTypeProvider).state;
    final userId = currentUser.id;
    final userInfo = KapiotUserInfo(
      points: 0,
      savedLocations: [],
      userType: userType,
    );
    userInfoRepo.pushUserInfo(userId: userId, userInfo: userInfo);
  }
}

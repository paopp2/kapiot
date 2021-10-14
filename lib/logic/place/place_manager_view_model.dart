import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/place/place_suggester.dart';
import 'package:kapiot/logic/shared/extensions.dart';
import 'package:kapiot/logic/shared/view_model.dart';

final placeManagerViewModel = Provider.autoDispose(
  (ref) => PlaceManagerViewModel(
    read: ref.read,
    placeSuggester: ref.watch(placeSuggesterProvider),
  ),
);

class PlaceManagerViewModel extends ViewModel {
  PlaceManagerViewModel({
    required Reader read,
    required this.placeSuggester,
  }) : super(read);
  final PlaceSuggester placeSuggester;
  final _appRouter = AppRouter.instance;
  final saveLocFocusNode = FocusNode();
  final tecSaveLoc = TextEditingController();

  void gotoSavePlaceView() => _appRouter.navigateTo(Routes.savePlaceView);

  void openSavePlacePicker() => _appRouter.navigateTo(Routes.savePlacePicker);

  void editPlaceAddress() => tecSaveLoc.selectText();

  Future<void> pickSuggestion({
    required String pickedSuggestion,
  }) async {
    tecSaveLoc.text = pickedSuggestion;
    placeSuggester.clearSuggestions();
  }
}

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/place_suggester.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/logic/shared/extensions.dart';

final placePickerViewModel = Provider.autoDispose(
  (ref) => PlacePickerViewModel(
    read: ref.read,
    mapController: ref.watch(homeMapController),
    placeSuggester: ref.watch(placeSuggesterProvider),
  ),
);

class PlacePickerViewModel extends ViewModel {
  PlacePickerViewModel({
    required Reader read,
    required this.mapController,
    required this.placeSuggester,
  }) : super(read);
  final HomeMapController mapController;
  final PlaceSuggester placeSuggester;
  final startLocFocusNode = FocusNode();
  final endLocFocusNode = FocusNode();
  final tecStartLoc = TextEditingController();
  final tecEndLoc = TextEditingController();

  @override
  void initState() {
    final isForStartLoc = read(isForStartLocProvider).state;
    final startAddress = read(startLocProvider).state?.address;
    final endAddress = read(endLocProvider).state?.address;
    tecStartLoc.text = startAddress ?? '';
    tecEndLoc.text = endAddress ?? '';
    if (isForStartLoc) {
      startLocFocusNode.requestFocus();
      tecStartLoc.selectText();
    } else {
      endLocFocusNode.requestFocus();
      tecEndLoc.selectText();
    }
  }

  @override
  void dispose() {
    startLocFocusNode.dispose();
    endLocFocusNode.dispose();

    mapController.showRouteIfBothLocationsSet(
      onRouteCalculated: (routeCoordinates) {
        read(routeCoordinatesProvider).state = routeCoordinates;
      },
    );
  }

  void gotoPlaceManagerView() {
    FocusManager.instance.primaryFocus?.unfocus(); // Close keyboard
    AppRouter.instance.navigateTo(Routes.placeManagerView);
  }

  void editPlaceAddress({required bool isForStartLoc}) {
    (isForStartLoc) ? tecStartLoc.selectText() : tecEndLoc.selectText();
    read(isForStartLocProvider).state = isForStartLoc;
  }

  Future<void> pickSuggestion({
    required String pickedSuggestion,
    required bool forStartLoc,
  }) async {
    final location = await placeSuggester.getLocation(pickedSuggestion);
    if (forStartLoc) {
      tecStartLoc.text = pickedSuggestion;
      mapController.setStartLocation(
        location?.copyWith(address: pickedSuggestion),
      );
      startLocFocusNode.unfocus();
    } else {
      tecEndLoc.text = pickedSuggestion;
      mapController.setEndLocation(
        location?.copyWith(address: pickedSuggestion),
      );
      endLocFocusNode.unfocus();
    }
    _returnIfBothLocationsSet();
  }

  void pickSavedLocation(KapiotLocation pickedSavedLoc) {
    final isForStartLoc = read(isForStartLocProvider).state;
    if (isForStartLoc) {
      tecStartLoc.text = pickedSavedLoc.address!;
      mapController.setStartLocation(pickedSavedLoc);
      startLocFocusNode.unfocus();
    } else {
      tecEndLoc.text = pickedSavedLoc.address!;
      mapController.setEndLocation(pickedSavedLoc);
      endLocFocusNode.unfocus();
    }
    _returnIfBothLocationsSet();
  }

  void _returnIfBothLocationsSet() {
    placeSuggester.clearSuggestions();
    final isStartLocSet = (read(startLocProvider).state != null);
    final isEndLocSet = (read(endLocProvider).state != null);
    if (isStartLocSet && isEndLocSet) {
      AppRouter.instance.popView();
    }
  }
}

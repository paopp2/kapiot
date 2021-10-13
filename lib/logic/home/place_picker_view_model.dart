import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/logic/extensions.dart';

final placePickerViewModel = Provider.autoDispose(
  (ref) => PlacePickerViewModel(
    read: ref.read,
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    mapController: ref.watch(homeMapController),
  ),
);

class PlacePickerViewModel extends ViewModel {
  PlacePickerViewModel({
    required Reader read,
    required this.mapController,
    required this.googleMapsApiServices,
  }) : super(read);
  final HomeMapController mapController;
  final GoogleMapsApiServices googleMapsApiServices;
  final startLocFocusNode = FocusNode();
  final endLocFocusNode = FocusNode();
  final tecStartLoc = TextEditingController();
  final tecEndLoc = TextEditingController();

  /// Used to store all autocomplete suggestion Maps in order to obtain the "id"
  /// from "address"
  List<Map<String, String?>> _autocompleteSuggestionMaps = [];

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
    // Select the text of the TextField to edit
    (isForStartLoc) ? tecStartLoc.selectText() : tecEndLoc.selectText();
    read(isForStartLocProvider).state = isForStartLoc;
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
    read(placeSuggestionsProvider).state = [];
    final isStartLocSet = (read(startLocProvider).state != null);
    final isEndLocSet = (read(endLocProvider).state != null);
    if (isStartLocSet && isEndLocSet) {
      AppRouter.instance.popView();
    }
  }

  void updateSuggestions(String? value) async {
    final suggestions = await googleMapsApiServices.places
        .getAutocompleteSuggestions(value ?? '');
    _autocompleteSuggestionMaps = suggestions;
    read(placeSuggestionsProvider).state =
        suggestions.map((s) => s["address"]).toList();
  }
}

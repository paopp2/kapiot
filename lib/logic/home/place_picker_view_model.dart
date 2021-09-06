import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/view_model.dart';

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

  @override
  void initState() {
    final isForStartLoc = read(isForStartLocProvider).state;
    final startAddress = read(startLocProvider).state?.address;
    final endAddress = read(endLocProvider).state?.address;
    tecStartLoc.text = startAddress ?? '';
    tecEndLoc.text = endAddress ?? '';
    if (isForStartLoc) {
      startLocFocusNode.requestFocus();
      tecStartLoc.selection = TextSelection(
        baseOffset: 0,
        extentOffset: tecStartLoc.text.length,
      );
    } else {
      endLocFocusNode.requestFocus();
      tecEndLoc.selection = TextSelection(
        baseOffset: 0,
        extentOffset: tecEndLoc.text.length,
      );
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

  /// Used to store all autocomplete suggestion Maps in order to obtain the "id"
  /// from "address"
  static List<Map<String, String?>> _autocompleteSuggestionMaps = [];

  void expandSuggestions({required bool isForStartLoc}) {
    if (isForStartLoc) {
      // Highlight all text within the startLoc TextField
      tecStartLoc.selection = TextSelection(
        baseOffset: 0,
        extentOffset: tecStartLoc.text.length,
      );
    } else {
      // Highlight all text within the endLoc TextField
      tecEndLoc.selection = TextSelection(
        baseOffset: 0,
        extentOffset: tecEndLoc.text.length,
      );
    }
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
  }

  void updateSuggestions(String? value) async {
    final suggestions = await googleMapsApiServices.places
        .getAutocompleteSuggestions(value ?? '');
    _autocompleteSuggestionMaps = suggestions;
    read(placeSuggestionsProvider).state =
        suggestions.map((s) => s["address"]).toList();
  }
}

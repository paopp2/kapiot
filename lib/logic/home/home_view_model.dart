import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

final homeViewModelProvider = Provider.autoDispose(
  (ref) => HomeViewModel(
    read: ref.read,
    authService: ref.watch(authServiceProvider),
    mapController: HomeMapController(
      read: ref.read,
      locationService: ref.watch(locationServiceProvider),
    ),
  ),
);

class HomeViewModel {
  HomeViewModel({
    required this.read,
    required this.authService,
    required this.mapController,
  });
  final Reader read;
  final AuthService authService;
  final HomeMapController mapController;
  final tecStartLoc = TextEditingController();
  final tecEndLoc = TextEditingController();
  late final CameraPosition initialCameraPosition;

  Future<void> initState() async {
    await mapController.initializeMap();
  }

  Future<void> signOut() async => await authService.signOutGoogle();

  void toggleIsRider(bool valueHasChanged) {
    if (valueHasChanged) {
      final currentIsRider = read(isRiderSelectedProvider).state;
      read(isRiderSelectedProvider).state = !currentIsRider;
    }
  }

  void incRiderCount() => read(riderCountProvider).state++;

  void decRiderCount() {
    if (read(riderCountProvider).state > 1) {
      read(riderCountProvider).state--;
    }
  }

  void getDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
      initialDate: DateTime.now(),
    );
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (date != null && time != null) {
      read(dateTimeProvider).state = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }
  }

  void showSuggestions({required bool forStartLoc}) {
    if (forStartLoc) {
      read(isStartLocFocusedProvider).state = true;
      read(isEndLocFocusedProvider).state = false;
    } else {
      read(isEndLocFocusedProvider).state = true;
      read(isStartLocFocusedProvider).state = false;
    }
  }

  Future<void> getAutoComplete(String? value) async {
    final googlePlace = GooglePlace("AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI");
    final result = await googlePlace.autocomplete.get(value ?? '');
    final predictions = result?.predictions ?? [];
    read(predictionsProvider).state = predictions;
  }

  Future<void> getFullDetails(String placeId) async {
    final googlePlace = GooglePlace("AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI");
    final details = await googlePlace.details.get(placeId);
    print(details);
  }

  void chooseSuggestion({
    required int index,
    required bool forStartLoc,
  }) {
    final predictions = read(predictionsProvider).state;
    final chosenPrediction = predictions[index];
    final chosenSuggestion = chosenPrediction.description ?? '';
    if (forStartLoc) {
      tecStartLoc.text = chosenSuggestion;
      read(isStartLocFocusedProvider).state = false;
    } else {
      tecEndLoc.text = chosenSuggestion;
      read(isEndLocFocusedProvider).state = false;
    }
    final placeId = chosenPrediction.placeId;
    if (placeId != null) getFullDetails(placeId);
  }

  void dispose() {}
}

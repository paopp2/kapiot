import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final homeViewModelProvider = Provider.autoDispose(
  (ref) => HomeViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    driverRepo: ref.watch(driverRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
    authService: ref.watch(authServiceProvider),
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    mapController: HomeMapController(
      read: ref.read,
      locationService: ref.watch(locationServiceProvider),
      googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    ),
  ),
);

class HomeViewModel {
  HomeViewModel({
    required this.read,
    required this.riderRepo,
    required this.driverRepo,
    required this.currentUser,
    required this.authService,
    required this.locationService,
    required this.googleMapsApiServices,
    required this.mapController,
  });
  final Reader read;
  final RiderRepository riderRepo;
  final DriverRepository driverRepo;
  final AuthService authService;
  final KapiotUser? currentUser;
  final HomeMapController mapController;
  final routeConfigKey = GlobalKey<FormState>();
  final tecStartLoc = TextEditingController();
  final tecEndLoc = TextEditingController();
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;
  late final CameraPosition initialCameraPosition;

  Future<void> initState() async {
    await mapController.initializeMap();
    final startLocation = read(startLocProvider).state;
    if (startLocation != null) {
      final currentPlace =
          await locationService.getAddressFromLocation(startLocation);
      tecStartLoc.text = currentPlace ?? '';
      read(startLocProvider).state =
          startLocation.copyWith(address: currentPlace);
    }
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

  void expandSuggestions({required bool forStartLoc}) {
    if (forStartLoc) {
      read(isStartLocFocusedProvider).state = true;
      read(isEndLocFocusedProvider).state = false;
    } else {
      read(isEndLocFocusedProvider).state = true;
      read(isStartLocFocusedProvider).state = false;
    }
  }

  void updateSuggestions(String? value) async {
    final suggestions = await googleMapsApiServices.places
        .getAutocompleteSuggestions(value ?? '');
    read(placeSuggestionsProvider).state = suggestions;
  }

  Future<void> pickSuggestion({
    required String pickedSuggestion,
    required bool forStartLoc,
  }) async {
    final location =
        await locationService.getLocationFromAddress(pickedSuggestion);
    if (forStartLoc) {
      tecStartLoc.text = pickedSuggestion;
      read(startLocProvider).state = KapiotLocation(
        lat: location.lat,
        lng: location.lng,
        address: pickedSuggestion,
      );
      read(isStartLocFocusedProvider).state = false;
    } else {
      tecEndLoc.text = pickedSuggestion;
      final endLocation = KapiotLocation(
        lat: location.lat,
        lng: location.lng,
        address: pickedSuggestion,
      );
      read(endLocProvider).state = endLocation;
      read(isEndLocFocusedProvider).state = false;
    }
    showRouteIfBothLocationsSet();
  }

  void showRouteIfBothLocationsSet() {
    final startLocation = read(startLocProvider).state;
    final endLocation = read(endLocProvider).state;
    if (startLocation != null && endLocation != null) {
      mapController.showRoute(
        start: startLocation,
        end: endLocation,
      );
    }
  }

  Future<void> pushRouteConfig() async {
    final isRider = read(isRiderSelectedProvider).state;
    if (isRider) {
      riderRepo.pushRiderConfig(RouteConfig.rider(
          user: currentUser!,
          timeOfTrip: read(dateTimeProvider).state,
          riderCount: read(riderCountProvider).state,
          startLocation: const KapiotLocation(
              lat: 37.423106,
              lng: -122.084262,
              address: "[RiderStart] Ampitheatre Pkwy, Mountain View"),
          endLocation: const KapiotLocation(
              lat: 37.423736,
              lng: -122.090060,
              address: "[RiderEnd] Rengstorff Ave, Mountain View")));
    } else {
      driverRepo.pushDriverConfig(RouteConfig.driver(
          user: currentUser!,
          timeOfTrip: read(dateTimeProvider).state,
          riderCount: read(riderCountProvider).state,
          encodedRoute: "Oten"));
    }
  }

  void dispose() {
    tecStartLoc.dispose();
    tecEndLoc.dispose();
  }
}

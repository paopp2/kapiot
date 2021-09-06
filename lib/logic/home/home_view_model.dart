import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final homeViewModel = Provider.autoDispose(
  (ref) => HomeViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    driverRepo: ref.watch(driverRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
    authService: ref.watch(authServiceProvider),
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    mapController: ref.watch(homeMapController),
  ),
);

class HomeViewModel extends ViewModel {
  HomeViewModel({
    required Reader read,
    required this.riderRepo,
    required this.driverRepo,
    required this.currentUser,
    required this.authService,
    required this.locationService,
    required this.googleMapsApiServices,
    required this.mapController,
  }) : super(read);
  final RiderRepository riderRepo;
  final DriverRepository driverRepo;
  final AuthService authService;
  final KapiotUser? currentUser;
  final HomeMapController mapController;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;
  final routeConfigKey = GlobalKey<FormState>();
  final tecStartLoc = TextEditingController();
  final tecEndLoc = TextEditingController();

  @override
  Future<void> initState() async {
    await mapController.initializeHomeMap();
    final startLocation = read(startLocProvider).state;
    if (startLocation != null) {
      final currentPlace =
          await locationService.getAddressFromLocation(startLocation);
      tecStartLoc.text = currentPlace ?? '';
      mapController.setStartLocation(
        startLocation.copyWith(address: currentPlace),
      );
    }
  }

  Future<void> signOut() async => await authService.signOutGoogle();

  void toggleIsRider(bool valueHasChanged) {
    if (valueHasChanged) {
      final isRider = read(isRiderProvider).state;
      read(isRiderProvider).state = !isRider;
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

  void openPlacePickerView({required bool isForStartLoc}) {
    read(isForStartLocProvider).state = isForStartLoc;
    AppRouter.instance.navigateTo(Routes.placePickerView);
  }

  Future<void> pushRouteConfig() async {
    assert(currentUser != null);
    final isRider = read(isRiderProvider).state;
    final startLoc = read(startLocProvider).state;
    final endLoc = read(endLocProvider).state;
    if (startLoc == null || endLoc == null) return;
    if (isRider) {
      final riderConfig = RouteConfig.rider(
        user: currentUser!,
        timeOfTrip: read(dateTimeProvider).state,
        riderCount: read(riderCountProvider).state,
        startLocation: startLoc,
        endLocation: endLoc,
      );
      riderRepo.pushRiderConfig(riderConfig);
      read(currentRouteConfigProvider).state = riderConfig;
      AppRouter.instance.navigateTo(Routes.requestDriversView);
    } else {
      final routeCoordinates = read(routeCoordinatesProvider).state!;
      assert(routeCoordinates.isNotEmpty);
      final encodedRoute =
          await googleMapsApiServices.utils.encodeRoute(routeCoordinates);
      final driverConfig = RouteConfig.driver(
        user: currentUser!,
        timeOfTrip: read(dateTimeProvider).state,
        riderCount: read(riderCountProvider).state,
        encodedRoute: encodedRoute,
      );
      driverRepo.pushDriverConfig(driverConfig);
      read(currentRouteConfigProvider).state = driverConfig;
      AppRouter.instance.navigateTo(Routes.riderManagerView);
    }
  }
}

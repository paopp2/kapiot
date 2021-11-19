import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
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
import 'package:kapiot/model/car/car.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final homeViewModel = Provider.autoDispose(
  (ref) {
    // Push InitUserInfoView when the currentUser has
    // not set the required user information yet
    ref.watch(currentUserInfoProvider).whenData((userInfo) {
      if (userInfo == null) {
        AppRouter.instance.navigateTo(Routes.initUserInfoView);
      }
    });

    return HomeViewModel(
      read: ref.read,
      riderRepo: ref.watch(riderRepositoryProvider),
      driverRepo: ref.watch(driverRepositoryProvider),
      currentUser: ref.watch(currentUserProvider),
      authService: ref.watch(authServiceProvider),
      locationService: ref.watch(locationServiceProvider),
      googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
      mapController: ref.watch(homeMapController),
    );
  },
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
    final getLocAttempt = await locationService.getLocation();
    getLocAttempt.fold(
      (error) => Fluttertoast.showToast(
        msg: 'Error retrieving current location',
      ),
      (currentLoc) async {
        await mapController.initializeHomeMap(currentLoc);
        final startLocation = read(startLocProvider)!;
        final getAddressAttempt =
            await locationService.getAddressFromLocation(startLocation);
        getAddressAttempt.fold(
          (error) => Fluttertoast.showToast(
            msg: 'Error retrieving current address',
          ),
          (address) {
            tecStartLoc.text = address;
            mapController.setStartLocation(
              startLocation.copyWith(address: address),
            );
          },
        );
      },
    );
  }

  Future<void> signOut() async => await authService.signOutGoogle();

  void gotoInitUserInfoView() =>
      AppRouter.instance.navigateTo(Routes.initUserInfoView);

  void gotoDriverRegisterView() =>
      AppRouter.instance.navigateTo(Routes.carRegisterView);

  void gotoPlaceManagerView() =>
      AppRouter.instance.navigateTo(Routes.placeManagerView);

  void openRoutePlacePicker({required bool isForStartLoc}) {
    read(isForStartLocProvider.notifier).state = isForStartLoc;
    AppRouter.instance.navigateTo(Routes.routePlacePicker);
  }

  void incRiderCount() {
    final chosenCarCapacity = read(chosenCarProvider)!.capacity;
    if (chosenCarCapacity > read(riderCountProvider)) {
      read(riderCountProvider.notifier).state++;
    } else {
      Fluttertoast.showToast(msg: 'Max capacity');
    }
  }

  void decRiderCount() {
    if (read(riderCountProvider.notifier).state > 1) {
      read(riderCountProvider.notifier).state--;
    }
  }

  void chooseCar(Car car) {
    read(chosenCarProvider.notifier).state = car;
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
      read(dateTimeProvider.notifier).state = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }
  }

  Future<void> pushRouteConfig(bool isRider) async {
    assert(currentUser != null);
    final startLoc = read(startLocProvider);
    final endLoc = read(endLocProvider);
    if (startLoc == null || endLoc == null) return;
    if (isRider) {
      final riderConfig = RouteConfig.rider(
        user: currentUser!,
        timeOfTrip: read(dateTimeProvider),
        riderCount: 1, // Rider can only book for themselves
        startLocation: startLoc,
        endLocation: endLoc,
      );
      riderRepo.pushRiderConfig(riderConfig);
      read(currentRouteConfigProvider.notifier).state = riderConfig;
      AppRouter.instance.navigateTo(Routes.requestDriversView);
    } else {
      final routeCoordinates = read(routeCoordinatesProvider.notifier).state!;
      assert(routeCoordinates.isNotEmpty);
      final encodedRoute = googleMapsApiServices.utils.encodeRoute(
        routeCoordinates,
      );
      final driverConfig = RouteConfig.driver(
        user: currentUser!,
        timeOfTrip: read(dateTimeProvider.notifier).state,
        maxRiderCount: read(riderCountProvider.notifier).state,
        startLocation: startLoc,
        endLocation: endLoc,
        encodedRoute: encodedRoute,
        rating: read(currentUserInfoProvider)
            .data!
            .value!
            .driverInfo!
            .averageRating,
        car: read(chosenCarProvider)!,
      );
      driverRepo.pushDriverConfig(driverConfig);
      read(currentRouteConfigProvider.notifier).state = driverConfig;
      AppRouter.instance.navigateTo(Routes.riderManagerView);
    }
    // Clear map before reusing at the next View
    mapController.clearMap();
  }

  // TODO: Assert no calls to this method in production
  void pushReadyMadeConfig(bool isRider) {
    if (isRider) {
      final riderConfig = RouteConfig.rider(
        user: currentUser!,
        timeOfTrip: DateTime.now(),
        riderCount: 1,
        startLocation: const KapiotLocation(
          lat: 10.3763113,
          lng: 123.9598846,
          address: "Jollibee, Cebu North Road, Consolacion, Cebu, Philippines",
        ),
        endLocation: const KapiotLocation(
          lat: 10.353185,
          lng: 123.949506,
          address:
              "Yasco Motor Parts Corporation, North Road, Mandaue City, Cebu, Philippines",
        ),
      );
      riderRepo.pushRiderConfig(riderConfig);
      read(currentRouteConfigProvider.notifier).state = riderConfig;
      AppRouter.instance.navigateTo(Routes.requestDriversView);
    } else {
      final driverConfig = RouteConfig.driver(
        user: currentUser!,
        timeOfTrip: DateTime.now(),
        maxRiderCount: 3,
        startLocation: const KapiotLocation(
          lat: 10.382435524276756,
          lng: 123.9716686421716,
          address:
              "Vito Pepito Compound, Cebu North Road, Pitogo, Consolacion, Cebu",
        ),
        endLocation: const KapiotLocation(
          lat: 10.341169565590683,
          lng: 123.94750715566467,
          address: "Pacific Mall Mandaue, U.N. Avenue, Mandaue City, Cebu",
        ),
        encodedRoute:
            "wxj~@setsVCJKPRVjAdBnAlBh@~@^z@L^j@pCp@xDf@|AdCtGTj@x@`Cn@nBh@dA\\p@xCbEfA~AhAjBd@~@lAfDNd@LbBTvAV`EPpCLxAPj@`ApBZh@j@t@~@v@bBdBdAv@RL|ElBfDxAtClA^Tb@Fb@TbA^v@Pf@BpA?rA@bAFx@Tx@b@dI~EpKrGpAj@|@PhBRfHd@|BLvAAdI[tDSjEMfCOt@C|CHpEXdEXhFd@hEf@`Dd@pB`@nHzArGdArEl@tHdAhBJd@@xBIVAfBT|@RhEbAhA\\\\sA?Eo@O",
        rating: '4.5',
        car: const Car(
          licensePlateNum: 'ABC 321',
          make: 'TOYOTA',
          model: 'FORTUNER',
          type: CarType.suv,
        ),
      );
      driverRepo.pushDriverConfig(driverConfig);
      read(currentRouteConfigProvider.notifier).state = driverConfig;
      AppRouter.instance.navigateTo(Routes.riderManagerView);
    }
    // Clear map before reusing at the next View
    mapController.clearMap();
  }
}

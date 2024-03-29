import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/animation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/constants/markers.dart';
import 'package:kapiot/data/repositories/location_repository.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_map_controller.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final requestDriversViewModel = Provider.autoDispose(
  (ref) => RequestDriversViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
    locationRepo: ref.watch(locationRepositoryProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    mapController: ref.watch(requestDriversMapController),
  ),
);

class RequestDriversViewModel extends ViewModel {
  RequestDriversViewModel({
    required Reader read,
    required this.riderRepo,
    required this.locationService,
    required this.locationRepo,
    required this.googleMapsApiServices,
    required this.mapController,
  }) : super(read);
  final RiderRepository riderRepo;
  final RequestDriversMapController mapController;
  final LocationService locationService;
  final LocationRepository locationRepo;
  final GoogleMapsApiServices googleMapsApiServices;
  final CarouselController driverCarouselController = CarouselController();

  StreamSubscription? _previewedDriverLocationSub;
  StreamSubscription? _acceptingDriverConfigSub;
  StreamSubscription? _compatibleDriverConfigsSub;

  @override
  Future<void> initState() async {
    await mapController.initializeRequestDriversMap();
    assert(read(currentRouteConfigProvider) != null);
    final routeConfig = read(currentRouteConfigProvider)!;

    mapController.addMarker(
      marker: Markers.currentUserLoc,
      location: routeConfig.startLocation,
    );

    final driverConfigStream = riderRepo.getAcceptingDriverConfigAsStream(
      routeConfig.user.id,
    );
    respondWhenDriverAccepts(driverConfigStream);
  }

  Future<void> requestDriver(String driverId) async {
    final currentRouteConfig = read(currentRouteConfigProvider)!;
    read(requestedDriverIdListProvider.notifier).update(
      (state) => state..add(driverId),
    );
    await riderRepo.requestDriver(
      driverId,
      currentRouteConfig,
    );
  }

  Stream<List<RouteConfig>> getCompatibleDriverConfigs() {
    final streamController = StreamController<List<RouteConfig>>();
    final currentRiderConfig = read(currentRouteConfigProvider)!;
    final compatibleDriverConfigsStream =
        riderRepo.getCompatibleDriverConfigsAsStream(currentRiderConfig);
    _compatibleDriverConfigsSub = compatibleDriverConfigsStream.listen(
      (driverConfigs) {
        autoSelectDriver(driverConfigs);
        streamController.add(driverConfigs);
      },
    );
    return streamController.stream;
  }

  void selectDriver(int? index) {
    read(selectedDriverIndexProvider.notifier).state = index;
  }

  // Auto selects and 'animates' to a driverCard in either case : the rider
  // hasn't picked one yet, the current selected driver's index is out of range,
  // driver list changed but current selected index still within range, no
  // available drivers
  Future<void> autoSelectDriver(List<RouteConfig> driverConfigs) async {
    final selectedIndex = read(selectedDriverIndexProvider);

    final bool isNoDriverSelected =
        driverConfigs.isNotEmpty && selectedIndex == null;
    final bool isDriverOutOfRange = selectedIndex != null &&
        driverConfigs.length <= selectedIndex &&
        driverConfigs.isNotEmpty;

    // Provides a slight delay to allow the stream data to 'settle', avoiding
    // erroneous UI rebuilds
    Future.delayed(const Duration(milliseconds: 200), () async {
      if (isNoDriverSelected || isDriverOutOfRange) {
        // If no driver selected or if out of range, select the first one
        // on the list
        selectDriver(0);
        previewDriverInfoAndLocation(driverConfigs[0]);
        driverCarouselController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else if (driverConfigs.isNotEmpty) {
        // If the driver list changed/adjusted but the selected driver index is
        // still within range, preview the new driver selected
        previewDriverInfoAndLocation(driverConfigs[selectedIndex!]);
      } else {
        // If driver list is empty
        final riderConfig = read(currentRouteConfigProvider)!;
        selectDriver(null);
        mapController.clearMap();
        mapController.animateToLocation(location: riderConfig.startLocation);
      }
    });
  }

  Future<void> previewDriverInfoAndLocation(RouteConfig driverConfig) async {
    await mapController.showSelectedDriverRoute(driverConfig);
    // Cancel the last chosen driver's location stream subscription and
    // subscribe to the new one
    _previewedDriverLocationSub?.cancel();
    KapiotLocation? prevDriverLoc; // Used for getting driver's car heading
    _previewedDriverLocationSub =
        locationRepo.getRealtimeLocation(driverConfig.user.id).listen(
      (driverLoc) {
        updateDriverDistance(driverLoc);
        mapController.addMarker(
          marker: Markers.driverLoc.copyWith(
            rotationParam: Geolocator.bearingBetween(
              prevDriverLoc?.lat ?? driverConfig.startLocation.lat,
              prevDriverLoc?.lng ?? driverConfig.startLocation.lng,
              driverLoc.lat,
              driverLoc.lng,
            ),
          ),
          location: driverLoc,
        );
        prevDriverLoc = driverLoc;
      },
    );
  }

  void updateDriverDistance(KapiotLocation driverLoc) {
    final utils = googleMapsApiServices.utils;
    final currentRouteConfig = read(currentRouteConfigProvider)!;
    final riderLoc = currentRouteConfig.startLocation;
    final distance = utils.calculateDistance(
      pointA: riderLoc,
      pointB: driverLoc,
    );
    read(driverDistanceProvider.notifier).state =
        '${distance.toStringAsFixed(1)} km';
  }

  /// Listen to when a driver accepts and respond accordingly
  Future<void> respondWhenDriverAccepts(
    Stream<RouteConfig?> acceptingDriverConfig,
  ) async {
    final currentRiderConfig = read(currentRouteConfigProvider);
    assert(currentRiderConfig != null);
    _acceptingDriverConfigSub = acceptingDriverConfig.listen((driverConfig) {
      if (driverConfig != null) {
        final riderId = currentRiderConfig!.user.id;
        riderRepo.deletePendingRequests(
          riderId,
          read(requestedDriverIdListProvider),
        );
        read(acceptingDriverConfigProvider.notifier).state = driverConfig;
        // Clear map before reusing at the next View
        mapController.clearMap();
        AppRouter.instance.navigateTo(Routes.requestAcceptedView);

        // Cancel all stream subscriptions
        _acceptingDriverConfigSub?.cancel();
        _previewedDriverLocationSub?.cancel();
        _compatibleDriverConfigsSub?.cancel();
      }
    });
  }
}

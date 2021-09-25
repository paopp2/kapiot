import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/constants/markers.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/driver_repository.dart';
import 'package:kapiot/data/repositories/location_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/driver/rider_manager_map_controller.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

final riderManagerViewModel = Provider.autoDispose(
  (ref) => RiderManagerViewModel(
    read: ref.read,
    driverRepo: ref.watch(driverRepositoryProvider),
    locationRepo: ref.watch(locationRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    coreAlgorithms: ref.watch(coreAlgorithmsProvider),
    mapController: ref.watch(riderManagerMapController),
    currentUser: ref.watch(currentUserProvider),
  ),
);

class RiderManagerViewModel extends ViewModel {
  RiderManagerViewModel({
    required Reader read,
    required this.driverRepo,
    required this.locationRepo,
    required this.locationService,
    required this.googleMapsApiServices,
    required this.coreAlgorithms,
    required this.mapController,
    required this.currentUser,
  }) : super(read);
  final DriverRepository driverRepo;
  final LocationRepository locationRepo;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;
  final CoreAlgorithms coreAlgorithms;
  final RiderManagerMapController mapController;
  final KapiotUser? currentUser;
  static final List<StopPoint> _finishedStopPoints = [];
  late final StreamSubscription stopPointsSub;
  late final StreamSubscription realtimeLocSub;

  @override
  Future<void> initState() async {
    await mapController.initializeRiderManagerMap();
    read(startTimeProvider).state = DateTime.now();
    print(read(startTimeProvider).state);
    final stopPointsStream = getStopPointsStream();
    stopPointsSub = stopPointsStream.listen((stopPointsList) {
      read(stopPointsProvider).state = stopPointsList;
      if (stopPointsList.isNotEmpty) {
        if (_finishedStopPoints.isEmpty) {
          read(nextStopProvider).state = stopPointsList.first;
        } else {
          int i = 0;
          StopPoint stop = stopPointsList[i];
          while (_finishedStopPoints.contains(stop)) {
            stop = stopPointsList[i++];
          }
          read(nextStopProvider).state = stop;
        }
      } else {
        _finishedStopPoints.clear();
        read(nextStopProvider).state = null;
      }
    });

    // Show the current driver's route on the map
    final utils = googleMapsApiServices.utils;
    final routeConfig = read(currentRouteConfigProvider).state as ForDriver;
    final encodedRoute = routeConfig.encodedRoute;
    await mapController.showRouteFromEncoded(encodedRoute: encodedRoute);

    // Show the current next stop on the map (if any)
    read(nextStopProvider).stream.listen((nextStop) {
      if (nextStop != null) {
        mapController.addMarker(
          marker: Markers.nextStopPoint,
          location: nextStop.stopLocation,
        );
      } else {
        mapController.removeMarker(Markers.nextStopPoint);
      }
    });

    // Push changes to this driver's location and return to HomeView once
    // this driver arrives at destination / end location
    final decodedRoute = await utils.decodeRoute(encodedRoute);
    final driverEndLocation = KapiotLocation(
      lat: decodedRoute.last.latitude,
      lng: decodedRoute.last.longitude,
    );
    realtimeLocSub = locationService.getLocationStream().listen((currentLoc) {
      assert(currentUser != null);
      final distToDriverEnd = utils.calculateDistance(
        pointA: currentLoc,
        pointB: driverEndLocation,
      );

      // If driver is less than 50m away from destination (arriving)
      if (distToDriverEnd < 0.050) {
        read(endTimeProvider).state = DateTime.now();
        print(read(endTimeProvider).state);
        MapController.reset(read);
        // Set a new resetKey; notifies the HomeView that it should reset
        read(resetKeyProvider).state = UniqueKey();
        // Remove all Views then navigate to HomeView
        AppRouter.instance.popAllThenNavigateTo(Routes.homeView);
      } else {
        mapController.addMarker(
          marker: Markers.driverLoc,
          location: currentLoc,
        );
        locationRepo.updateLocation(currentUser!.id, currentLoc);
      }
    });
  }

  @override
  void dispose() {
    stopPointsSub.cancel();
    realtimeLocSub.cancel();
  }

  Stream<List<KapiotUser>> getRequestingRidersStream() =>
      driverRepo.getRequestingRidersStream(currentUser!);

  Stream<List<StopPoint>> getStopPointsStream() {
    final currentDriverConfig = read(currentRouteConfigProvider).state!;
    return driverRepo.getStopPointsStream(currentDriverConfig);
  }

  void acceptRider(String riderId) {
    final currentDriverConfig = read(currentRouteConfigProvider).state;
    assert(currentDriverConfig != null);
    driverRepo.acceptRider(
      riderId,
      currentDriverConfig!,
    );
  }

  Future<void> updateNextStop() async {
    final currentStop = read(nextStopProvider).state!;
    _finishedStopPoints.add(currentStop);
    if (currentStop.isPickUp) {
      final stopPointsList = read(stopPointsProvider).state;
      final currentIndex = stopPointsList.indexOf(currentStop);
      read(nextStopProvider).state = stopPointsList[currentIndex + 1];
    } else {
      final currentDriverConfig = read(currentRouteConfigProvider).state!;
      final riderConfigList = read(riderConfigListProvider).state;
      driverRepo.removeRiderFromAccepted(
        currentDriverConfig.user.id,
        currentStop.riderConfig.user.id,
      );
      riderConfigList.add(currentStop.riderConfig);
      read(riderConfigListProvider).state = riderConfigList;
      await updateDriverPoints(currentStop.riderConfig);
    }
  }

  Future<void> updateDriverPoints(RouteConfig riderConfig) async {
    riderConfig as ForRider;
    final currentDriverPoints = read(driverPointsProvider).state;
    final pointsToAdd =
        await coreAlgorithms.calculateDriverPointsFromRider(riderConfig);
    read(driverPointsProvider).state = currentDriverPoints + pointsToAdd;
  }
}

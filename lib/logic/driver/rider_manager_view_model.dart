import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
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
  final List<StopPoint> _finishedStopPoints = [];
  final List<RouteConfig> _riderConfigList = [];
  final carouselController = CarouselController();
  late final StreamSubscription stopPointsSub;
  late final StreamSubscription realtimeLocSub;

  @override
  Future<void> initState() async {
    await mapController.initializeRiderManagerMap();
    final routeConfig = read(currentRouteConfigProvider) as ForDriver;
    read(transactionProvider.notifier).update(
      (state) => state.copyWith(
        driver: routeConfig,
        startTime: DateTime.now(),
      ),
    );

    // Show the current driver's route on the map
    final encodedRoute = routeConfig.encodedRoute;
    await mapController.showRouteFromEncoded(encodedRoute: encodedRoute);

    // Stream of current driver's stop points (pickup/dropoff locations)
    final stopPointsStream = getStopPointsStream();
    stopPointsSub = stopPointsStream.listen((stopPointsList) {
      read(stopPointsProvider.notifier).state = stopPointsList;
      read(nextStopProvider.notifier).update((_) {
        if (stopPointsList.isNotEmpty) {
          if (_finishedStopPoints.isEmpty) {
            return stopPointsList.first;
          } else {
            int i = 0;
            StopPoint stop = stopPointsList[i];
            while (_finishedStopPoints.contains(stop)) {
              stop = stopPointsList[i++];
            }
            return stop;
          }
        } else {
          _finishedStopPoints.clear();
          return null;
        }
      });
    });

    // Show the current next stop on the map (if any)
    read(nextStopProvider.notifier).stream.listen((nextStop) {
      if (nextStop != null) {
        mapController.addMarker(
          marker:
              (nextStop.isPickUp) ? Markers.pickupPoint : Markers.dropoffPoint,
          location: nextStop.stopLocation,
        );
      } else {
        // pickupPoint and dropoffPoint have the same Marker ID
        // 'next_stop_point' so this should remove either of them
        mapController.removeMarker(Markers.pickupPoint);
      }
    });

    // Push changes to this driver's location and return to HomeView once
    // this driver arrives at destination / end location
    KapiotLocation? prevLoc; // Used for getting driver's car heading
    realtimeLocSub = locationService.getLocationStream().listen((currentLoc) {
      assert(currentUser != null);
      final utils = googleMapsApiServices.utils;
      final distToDriverEnd = utils.calculateDistance(
        pointA: currentLoc,
        pointB: routeConfig.endLocation,
      );

      // If driver is less than 100m away from destination (arriving)
      if (distToDriverEnd < 0.100) {
        read(transactionProvider.notifier).update(
          (state) => state.copyWith(
            endTime: DateTime.now(),
            riders: _riderConfigList,
            points: read(driverPointsProvider),
          ),
        );
        realtimeLocSub.cancel();
        driverRepo.removeDriverConfig(currentUser!.id);
        AppRouter.instance.navigateTo(Routes.postTripSummaryView);
      } else {
        mapController.addMarker(
          marker: Markers.driverLoc.copyWith(
            rotationParam: Geolocator.bearingBetween(
              prevLoc?.lat ?? routeConfig.startLocation.lat,
              prevLoc?.lng ?? routeConfig.startLocation.lng,
              currentLoc.lat,
              currentLoc.lng,
            ),
          ),
          location: currentLoc,
        );
        prevLoc = currentLoc;
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

  Stream<List<KapiotUser>> getAcceptedRidersStream() => driverRepo
      .getAcceptedRidersStream(currentUser!.id)
      .map((rcList) => rcList.map((rc) => rc.user).toList());

  Stream<List<StopPoint>> getStopPointsStream() {
    final currentDriverConfig = read(currentRouteConfigProvider)!;
    return driverRepo.getStopPointsStream(currentDriverConfig);
  }

  void acceptRider(String riderId) {
    final currentDriverConfig = read(currentRouteConfigProvider) as ForDriver;
    if (!currentDriverConfig.isCarFull) {
      driverRepo.acceptRider(
        riderId,
        currentDriverConfig,
      );
      updateRiderCount(increment: true);
    } else {
      Fluttertoast.showToast(msg: "Car is at full capacity");
    }
  }

  Future<void> updateNextStop() async {
    final currentStop = read(nextStopProvider)!;
    _finishedStopPoints.add(currentStop);
    if (currentStop.isPickUp) {
      final stopPointsList = read(stopPointsProvider);
      final currentIndex = stopPointsList.indexOf(currentStop);
      read(nextStopProvider.notifier).state = stopPointsList[currentIndex + 1];
    } else {
      final currentDriverConfig = read(currentRouteConfigProvider)!;
      driverRepo.removeRiderFromAccepted(
        currentDriverConfig.user.id,
        currentStop.riderConfig.user.id,
      );
      _riderConfigList.add(currentStop.riderConfig);
      updateRiderCount(increment: false);
      await updateDriverPoints(currentStop.riderConfig);
    }
  }

  Future<void> updateRiderCount({required bool increment}) async {
    read(currentRouteConfigProvider.notifier).update((state) {
      state as ForDriver;
      int riderCount = state.currentRiderCount;
      final updatedConfig = state.copyWith(
        currentRiderCount: (increment) ? ++riderCount : --riderCount,
      );
      driverRepo.pushDriverConfig(updatedConfig);
      return updatedConfig;
    });
  }

  Future<void> updateDriverPoints(RouteConfig riderConfig) async {
    riderConfig as ForRider;
    final pointsToAdd =
        await coreAlgorithms.calculateDriverPointsFromRider(riderConfig);
    read(driverPointsProvider.notifier)
        .update((state) => (state + pointsToAdd));
  }

  /// Autocenters/autoselects a new ridercard after a rider has been accepted
  ///
  /// This is required as the accepted rider (previously centered ridercard)
  /// will be removed from the requesting riders list
  Future<void> autocenterRiderCard({
    required int currentIndex,
    required int maxIndex,
  }) async {
    Future.delayed(Duration.zero, () {
      carouselController.animateToPage(
        (currentIndex == maxIndex) ? 0 : currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }
}

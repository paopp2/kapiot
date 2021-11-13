import 'dart:async';

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

  StreamSubscription? _previewedDriverLocationSub;
  StreamSubscription? _acceptingDriverConfigSub;

  @override
  Future<void> initState() async {
    await mapController.initializeRequestDriversMap();
    assert(read(currentRouteConfigProvider).state != null);
    final routeConfig = read(currentRouteConfigProvider).state! as ForRider;

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
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    assert(currentRouteConfig != null);
    await riderRepo.requestDriver(
      driverId,
      currentRouteConfig!,
    );
  }

  Stream<List<RouteConfig>> getCompatibleDriverConfigs() {
    final currentRiderConfig = read(currentRouteConfigProvider).state!;
    return riderRepo.getCompatibleDriverConfigsAsStream(currentRiderConfig);
  }

  void selectDriver(int index) {
    read(selectedDriverIndexProvider).state = index;
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
    final currentRouteConfig = read(currentRouteConfigProvider).state!;
    final riderLoc = currentRouteConfig.startLocation;
    final distance = utils.calculateDistance(
      pointA: riderLoc,
      pointB: driverLoc,
    );
    read(driverDistanceProvider).state = '${distance.toStringAsFixed(1)} km';
  }

  /// Listen to when a driver accepts and respond accordingly
  Future<void> respondWhenDriverAccepts(
    Stream<RouteConfig?> acceptingDriverConfig,
  ) async {
    final currentRiderConfig = read(currentRouteConfigProvider).state;
    assert(currentRiderConfig != null);
    _acceptingDriverConfigSub = acceptingDriverConfig.listen((driverConfig) {
      if (driverConfig != null) {
        final riderId = currentRiderConfig!.user.id;
        riderRepo.deletePendingRequests(riderId);
        read(acceptingDriverConfigProvider).state = driverConfig;

        // Clear map before reusing at the next View
        mapController.clearMap();
        AppRouter.instance.navigateTo(Routes.requestAcceptedView);

        // Cancel all stream subscriptions
        _acceptingDriverConfigSub?.cancel();
        _previewedDriverLocationSub?.cancel();
      }
    });
  }
}

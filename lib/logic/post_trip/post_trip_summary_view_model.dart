import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final postTripSummaryViewModel = Provider.autoDispose(
  (ref) => PostTripSummaryViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    coreAlgorithms: ref.watch(coreAlgorithmsProvider),
  ),
);

class PostTripSummaryViewModel extends ViewModel {
  PostTripSummaryViewModel({
    required Reader read,
    required this.riderRepo,
    required this.googleMapsApiServices,
    required this.coreAlgorithms,
  }) : super(read);
  final RiderRepository riderRepo;
  final GoogleMapsApiServices googleMapsApiServices;
  final CoreAlgorithms coreAlgorithms;

  @override
  Future<void> initState() async {
    // TODO: Remove delay after refactoring RouteConfig for driver
    await Future.delayed(const Duration(milliseconds: 10));
    assert(read(currentRouteConfigProvider).state != null);
    final currentRouteConfig = read(currentRouteConfigProvider).state!;
    await setTransaction(currentRouteConfig);
  }

  Future<void> setTransaction(RouteConfig routeConfig) async {
    final utils = googleMapsApiServices.utils;
    final userId = routeConfig.user.id;
    final transaction = read(transactionProvider).state;
    if (routeConfig is ForDriver) {
      final decodedRoute = await utils.decodeRoute(routeConfig.encodedRoute);
      final LatLng start = decodedRoute.first;
      final LatLng end = decodedRoute.last;
      final startLoc = KapiotLocation(
        lat: start.latitude,
        lng: start.longitude,
      );
      final endLoc = KapiotLocation(
        lat: end.latitude,
        lng: end.longitude,
      );
      final double distance = utils.calculateDistance(
        pointA: startLoc,
        pointB: endLoc,
      );
      read(transactionProvider).state = transaction.copyWith(
        currentUserId: userId,
        driver: routeConfig,
        distance: distance,
        startLocation: startLoc,
        endLocation: endLoc,
      );
    } else if (routeConfig is ForRider) {
      assert(read(acceptingDriverConfigProvider).state != null);
      final startLoc = routeConfig.startLocation;
      final endLoc = routeConfig.endLocation;
      final double distance =
          utils.calculateDistance(pointA: startLoc, pointB: endLoc);
      read(transactionProvider).state = transaction.copyWith(
        currentUserId: userId,
        distance: distance,
        startLocation: startLoc,
        endLocation: endLoc,
      );
    }
  }

  void resetToHomeView() {
    MapController.reset(read);
    // Set a new resetKey; notifies the HomeView that it should reset
    read(resetKeyProvider).state = UniqueKey();
    // Remove all Views then navigate to HomeView
    AppRouter.instance.popAllThenNavigateTo(Routes.homeView);
  }
}

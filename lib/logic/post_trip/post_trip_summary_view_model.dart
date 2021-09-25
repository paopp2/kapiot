import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/transaction/transaction.dart';

final postTripSummaryViewModel = Provider.autoDispose(
  (ref) => PostTripSummaryViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    coreAlgorithms: ref.watch(coreAlgorithmsProvider),
  ),
);

class PostTripSummaryViewModel extends ViewModel {
  PostTripSummaryViewModel({
    required Reader read,
    required this.riderRepo,
    required this.currentUser,
    required this.googleMapsApiServices,
    required this.coreAlgorithms,
  }) : super(read);
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;
  final GoogleMapsApiServices googleMapsApiServices;
  final CoreAlgorithms coreAlgorithms;

  @override
  Future<void> initState() async {
    assert(read(acceptingDriverConfigProvider).state != null);
    assert(read(currentRouteConfigProvider).state != null);
    assert(currentUser != null);
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    final currentUserId = currentUser!.id;
    // TODO: Refactor
    if (currentRouteConfig is ForDriver) {
      final riders = read(riderConfigListProvider).state;
      final decodedRoute = await googleMapsApiServices.utils
          .decodeRoute(currentRouteConfig.encodedRoute);
      final LatLng startLoc = decodedRoute[0];
      final LatLng endLoc = decodedRoute[decodedRoute.length - 1];
      final KapiotLocation pointA =
          KapiotLocation(lat: startLoc.latitude, lng: startLoc.longitude);
      final KapiotLocation pointB =
          KapiotLocation(lat: endLoc.latitude, lng: endLoc.longitude);
      final double distance = await googleMapsApiServices.distMatrix
          .getDistanceValue(pointA: pointA, pointB: pointB);
      final int points = read(driverPointsProvider).state.toInt();
      final DateTime startTime = read(startTimeProvider).state;
      final DateTime endTime = read(endTimeProvider).state;

      final Transaction transaction = Transaction(
          currentUserId: currentUserId,
          driver: currentRouteConfig,
          riders: riders,
          points: points,
          startTime: startTime,
          endTime: endTime,
          distance: distance);
    }
  }

  @override
  void dispose() {}
}

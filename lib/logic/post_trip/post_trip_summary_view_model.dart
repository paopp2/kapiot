import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final postTripSummaryViewModel = Provider.autoDispose(
  (ref) => PostTripSummaryViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    userInfoRepo: ref.watch(userInfoRepositoryProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    coreAlgorithms: ref.watch(coreAlgorithmsProvider),
  ),
);

class PostTripSummaryViewModel extends ViewModel {
  PostTripSummaryViewModel({
    required Reader read,
    required this.riderRepo,
    required this.userInfoRepo,
    required this.googleMapsApiServices,
    required this.coreAlgorithms,
  }) : super(read);
  final RiderRepository riderRepo;
  final UserInfoRepository userInfoRepo;
  final GoogleMapsApiServices googleMapsApiServices;
  final CoreAlgorithms coreAlgorithms;

  @override
  void initState() {
    assert(read(currentRouteConfigProvider).state != null);
    final currentRouteConfig = read(currentRouteConfigProvider).state!;
    completeTransaction(currentRouteConfig);
    updateTotalPoints();
  }

  void completeTransaction(RouteConfig routeConfig) {
    final utils = googleMapsApiServices.utils;
    final userId = routeConfig.user.id;
    final transaction = read(transactionProvider).state;
    final distance = utils.calculateDistance(
      pointA: routeConfig.startLocation,
      pointB: routeConfig.endLocation,
    );
    // Asynchronously update transactionProvider to avoid premature rebuilding
    Future.delayed(Duration.zero, () {
      read(transactionProvider).state = transaction.copyWith(
        currentUserId: userId,
        distance: distance,
        startLocation: routeConfig.startLocation,
        endLocation: routeConfig.endLocation,
      );
    });
  }

  void updateTotalPoints() {
    final currentUserInfo = read(currentUserInfoProvider).data!.value!;
    final pointsToAdd = read(transactionProvider).state.points!;
    final newTotal = currentUserInfo.points + pointsToAdd;
    userInfoRepo.pushUserInfo(
      userId: read(currentUserProvider)!.id,
      userInfo: currentUserInfo.copyWith(points: newTotal),
    );
  }

  void resetToHomeView() {
    // Clear shared Map state
    MapController.reset(read);
    // Set a new resetKey; notifies the HomeView that it should reset
    read(resetKeyProvider).state = UniqueKey();
    // Remove all Views then navigate to HomeView
    AppRouter.instance.popAllThenNavigateTo(Routes.homeView);
  }
}

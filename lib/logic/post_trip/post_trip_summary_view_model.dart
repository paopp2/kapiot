import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/repositories/user_info_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_state.dart';
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

  StreamSubscription? _acceptingDriverInfoSub;

  @override
  void initState() {
    assert(read(currentRouteConfigProvider).state != null);
    final currentRouteConfig = read(currentRouteConfigProvider).state!;
    completeTransaction(currentRouteConfig);
    updateTotalPoints();
  }

  Future<void> showRateDriverDialog({required Widget dialog}) async {
    final isRider = (read(currentRouteConfigProvider).state is ForRider);
    if (isRider) {
      // Show the dialog only once at the start of the PostTripSummaryView
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        showDialog(
          context: AppRouter.instance.navigationKey.currentContext!,
          builder: (context) => dialog,
        );
      });
    }
  }

  void setRating(int rating) {
    read(ratingProvider).state = rating;
    print(read(ratingProvider).state);
  }

  Future<void> updateDriverRating() async {
    final acceptingDriverConfig = read(acceptingDriverConfigProvider).state;
    final driverInfoStream = userInfoRepo.getDriverInfoStream(
      acceptingDriverConfig!.user.id,
    );
    final currentRiderConfig = read(currentRouteConfigProvider).state;
    assert(currentRiderConfig != null);
    _acceptingDriverInfoSub = driverInfoStream.listen((driverInfo) {
      if (driverInfo != null) {
        read(acceptingDriverInfoProvider).state = driverInfo;
      }
    });

    final acceptingDriverInfo = read(acceptingDriverInfoProvider).state;
    final driverRating = acceptingDriverInfo!.rating;

    //TODO: Calculate rating. May not be possible at the moment.

    _acceptingDriverInfoSub?.cancel();
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

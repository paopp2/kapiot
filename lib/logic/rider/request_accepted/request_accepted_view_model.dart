import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/constants/markers.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/data/repositories/location_repository.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'request_accepted_map_controller.dart';

final requestAcceptedViewModel = Provider.autoDispose(
  (ref) => RequestAcceptedViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
    locationRepo: ref.watch(locationRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    mapController: ref.watch(requestAcceptedMapController),
  ),
);

class RequestAcceptedViewModel extends ViewModel {
  RequestAcceptedViewModel({
    required Reader read,
    required this.riderRepo,
    required this.currentUser,
    required this.locationService,
    required this.locationRepo,
    required this.googleMapsApiServices,
    required this.mapController,
  }) : super(read);
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;
  final RequestAcceptedMapController mapController;
  final LocationRepository locationRepo;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;
  static final List<RouteConfig> _riderList = [];
  late final StreamSubscription isDroppedOffStreamSub;
  late final StreamSubscription driverLocStreamSub;
  late final StreamSubscription coRiderConfigSub;

  @override
  Future<void> initState() async {
    assert(read(acceptingDriverConfigProvider).state != null);
    assert(read(currentRouteConfigProvider).state != null);
    assert(currentUser != null);

    await mapController.initializeRequestAcceptedMap();
    // This delay of arbitrary duration allows the map to finish initializing
    // before showing the acceptingDriver's route. Removing this delay seems to
    // result to a race condition. Should anyone have a better alternative to
    // this workaround, feel free to send a pull request
    await Future.delayed(const Duration(milliseconds: 50));
    mapController.showAcceptingDriverRoute();

    // Add markers for the current rider's start and end loc on the map
    final routeConfig = read(currentRouteConfigProvider).state! as ForRider;
    mapController
      ..addMarker(
        marker: Markers.currentUserLoc,
        location: routeConfig.startLocation,
      )
      ..addMarker(
        marker: Markers.riderEndLoc,
        location: routeConfig.endLocation,
      );

    // StreamSub that listens to the Stream that emits the accepting driver's
    // realtime location
    final acceptingDriver = read(acceptingDriverConfigProvider).state!;
    final driverId = acceptingDriver.user.id;
    driverLocStreamSub = locationRepo.getRealtimeLocation(driverId).listen(
      (driverLoc) {
        mapController.addMarker(
          marker: Markers.driverLoc,
          location: driverLoc,
        );
      },
    );

    final transaction = read(transactionProvider).state;
    read(transactionProvider).state = transaction.copyWith(
      startTime: DateTime.now(),
      driver: acceptingDriver,
    );

    // StreamSub that listens to the Stream that emits the current rider's
    // co-riders to be added to the current Transaction's [riders]
    coRiderConfigSub = getMyCoRiderConfigsStream().listen((rcList) {
      final newCoRiders =
          rcList.where((rc) => (!_riderList.contains(rc))).toList();
      _riderList.addAll(newCoRiders);
    });

    // StreamSub that listens to the Stream that emits when this current rider
    // has been 'dropped off'
    isDroppedOffStreamSub = isDroppedOffStream().listen((isDroppedOff) {
      if (isDroppedOff) {
        // Update current transaction data
        final transaction = read(transactionProvider).state;
        read(transactionProvider).state = transaction.copyWith(
          endTime: DateTime.now(),
          points: 10,
          riders: _riderList,
        );

        // Cancel all StreamSubs at RequestAcceptedView
        coRiderConfigSub.cancel();
        isDroppedOffStreamSub.cancel();
        driverLocStreamSub.cancel();

        // Navigate to PostTripSummaryView
        AppRouter.instance.navigateTo(Routes.postTripSummaryView);
      }
    });
  }

  /// Remaps the stream containing all riderConfigs that have been accepted by
  /// the current rider's acceptingDriver except for the current rider
  Stream<List<RouteConfig>> getMyCoRiderConfigsStream() {
    final acceptingDriverConfig = read(acceptingDriverConfigProvider).state!;
    final allCoRiderConfigsStream = riderRepo.getAllCoRiderConfigsStream(
      driver: acceptingDriverConfig.user,
    );
    // Filter out current rider's RouteConfig
    return allCoRiderConfigsStream.map(
      (riderList) {
        return riderList
            .where((rider) => (rider.user.id != currentUser!.id))
            .toList();
      },
    );
  }

  /// Stream that listens whether this rider has already been "dropped off"
  ///
  /// When the acceptingDriver drops off a rider, the driver deletes the rider
  /// from the driver's "accepted" collection. Listening for when this happens
  /// signifies the app as to when this rider is dropped off.
  Stream<bool> isDroppedOffStream() async* {
    final acceptingDriverConfig = read(acceptingDriverConfigProvider).state!;
    final allCoRiderConfigsStream = riderRepo.getAllCoRiderConfigsStream(
      driver: acceptingDriverConfig.user,
    );
    await for (final coRidersList in allCoRiderConfigsStream) {
      final hasRider = coRidersList.any(
        (rider) => (rider.user.id == currentUser!.id),
      );
      yield !hasRider;
    }
  }
}

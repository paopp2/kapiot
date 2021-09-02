import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final requestDriversViewModel = Provider.autoDispose(
  (ref) => RequestDriversViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    locationService: ref.watch(locationServiceProvider),
    googleMapsApiServices: ref.watch(googleMapsApiServicesProvider),
    mapController: ref.watch(requestDriversMapController),
  ),
);

class RequestDriversViewModel extends ViewModel {
  RequestDriversViewModel({
    required Reader read,
    required this.riderRepo,
    required this.locationService,
    required this.googleMapsApiServices,
    required this.mapController,
  }) : super(read);
  final RiderRepository riderRepo;
  final RequestDriversMapController mapController;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;

  @override
  Future<void> initState() async {
    await mapController.initializeRequestDriversMap();

    assert(read(currentRouteConfigProvider).state != null);
    final routeConfig = read(currentRouteConfigProvider).state!;
    final driverConfigStream = riderRepo.getAcceptingDriverConfigAsStream(
      routeConfig.user.id,
    );
    // Listen to when a driver accepts and respond accordingly
    respondWhenDriverAccepts(driverConfigStream);

    // Show the route of the first compatible driver on the list
    final compatibleDrivers = await getCompatibleDriverConfigs().first;
    if (compatibleDrivers.isNotEmpty) {
      mapController.showSelectedDriverRoute(compatibleDrivers.first);
    }
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

  Future<void> respondWhenDriverAccepts(
    Stream<RouteConfig?> acceptingDriverConfig,
  ) async {
    final currentRiderConfig = read(currentRouteConfigProvider).state;
    assert(currentRiderConfig != null);
    acceptingDriverConfig.listen((driverConfig) {
      if (driverConfig != null) {
        final riderId = currentRiderConfig!.user.id;
        riderRepo.deletePendingRequests(riderId);
        read(acceptingDriverConfigProvider).state = driverConfig;
        AppRouter.instance.navigateTo(Routes.requestAcceptedView);
      }
    });
  }
}

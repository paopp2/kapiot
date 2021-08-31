import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
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
  late final Stream<KapiotUser?> _acceptingDriver;
  late final RouteConfig _routeConfig;
  final RequestDriversMapController mapController;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;

  @override
  Future<void> initState() async {
    await mapController.initializeRequestDriversMap();
    // Show the route of the first compatible driver on the list
    final compatibleDrivers = await getCompatibleDriverConfigs().first;
    showDriverRoute(compatibleDrivers[0]);

    assert(read(currentRouteConfigProvider).state != null);
    _routeConfig = read(currentRouteConfigProvider).state!;
    _acceptingDriver = riderRepo.getAcceptingDriverAsStream(
      _routeConfig.user.id,
    );
    // Listen to when a driver accepts and respond accordingly
    respondWhenDriverAccepts(_acceptingDriver);
  }

  Future<void> showDriverRoute(RouteConfig driverConfig) async {
    final driverEncodedRoute = (driverConfig is ForDriver)
        ? driverConfig.encodedRoute
        : throw Exception("Not ForDriver");
    final driverDecodedRoute =
        await googleMapsApiServices.utils.decodeRoute(driverEncodedRoute);
    mapController.setStartLocation(
      KapiotLocation(
        lat: driverDecodedRoute.first.latitude,
        lng: driverDecodedRoute.first.longitude,
      ),
    );
    mapController.setEndLocation(
      KapiotLocation(
        lat: driverDecodedRoute.last.latitude,
        lng: driverDecodedRoute.last.longitude,
      ),
    );
    mapController.showRouteIfBothLocationsSet();
  }

  Future<void> requestDriver(String driverId) async {
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    assert(currentRouteConfig != null);
    await riderRepo.requestDriver(
      driverId,
      currentRouteConfig!,
    );
  }

  Stream<List<RouteConfig>> getCompatibleDriverConfigs() =>
      riderRepo.getCompatibleDriverConfigs();

  Future<void> respondWhenDriverAccepts(
    Stream<KapiotUser?> acceptingDriver,
  ) async {
    final currentRiderConfig = read(currentRouteConfigProvider).state;
    assert(currentRiderConfig != null);
    acceptingDriver.listen((driver) {
      if (driver != null) {
        final riderId = currentRiderConfig!.user.id;
        riderRepo.deletePendingRequests(riderId);
        read(acceptingDriverProvider).state = driver;
        AppRouter.instance.navigateTo(Routes.requestAcceptedView);
      }
    });
  }
}

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
import 'request_drivers_view_state.dart';

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
    assert(read(currentRouteConfigProvider).state != null);
    _routeConfig = read(currentRouteConfigProvider).state!;
    _acceptingDriver = riderRepo.getAcceptingDriverAsStream(
      _routeConfig.user.id,
    );
    respondWhenDriverAccepts(_acceptingDriver);
    await mapController.initializeMap();
    final startLocation = read(driverStartLocProvider).state;
    if (startLocation != null) {
      final currentPlace =
          await locationService.getAddressFromLocation(startLocation);
      read(driverStartLocProvider).state =
          startLocation.copyWith(address: currentPlace);
    }
  }

  // TODO: Refactor
  void showRouteIfBothLocationsSet() async {
    final startLocation = read(driverStartLocProvider).state;
    final endLocation = read(driverEndLocProvider).state;
    if (startLocation != null && endLocation != null) {
      final routeCoordinates = await mapController.getRouteCoordinates(
        start: startLocation,
        end: endLocation,
      );
      read(driverRouteCoordinatesProvider).state = routeCoordinates;
      mapController.showRoute(
        start: startLocation,
        end: endLocation,
        routeCoordinates: routeCoordinates,
      );
    }
  }

  Future<void> showDriverRoute(RouteConfig driverConfig) async {
    final driverEncodedRoute = (driverConfig is ForDriver)
        ? driverConfig.encodedRoute
        : throw Exception("Not ForDriver");
    final driverDecodedRoute =
        await googleMapsApiServices.utils.decodeRoute(driverEncodedRoute);
    final driverStartRouteLat = driverDecodedRoute.first.latitude;
    final driverStartRouteLng = driverDecodedRoute.first.longitude;
    final driverEndRouteLat = driverDecodedRoute.last.latitude;
    final driverEndRouteLng = driverDecodedRoute.last.longitude;
    read(driverStartLocProvider).state = KapiotLocation(
      lat: driverStartRouteLat,
      lng: driverStartRouteLng,
    );
    read(driverEndLocProvider).state = KapiotLocation(
      lat: driverEndRouteLat,
      lng: driverEndRouteLng,
    );
    if (read(driverStartLocProvider).state != null &&
        read(driverEndLocProvider).state != null) {
      showRouteIfBothLocationsSet();
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

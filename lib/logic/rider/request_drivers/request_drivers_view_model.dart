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
    final startLocation = read(startLocProvider).state;
    if (startLocation != null) {
      final currentPlace =
          await locationService.getAddressFromLocation(startLocation);
      read(startLocProvider).state =
          startLocation.copyWith(address: currentPlace);
    }
  }

  Future<void> getDriverEncodedRoute(String driverId) async {
    final driverEndcodedRoute = await riderRepo.getDriverEncodedRoute(driverId);
    print('Encoded Route $driverEndcodedRoute');
    final driverDecodedRoute =
        await googleMapsApiServices.utils.decodeRoute(driverEndcodedRoute!);
    final driverRouteLat = driverDecodedRoute[0].latitude;
    final driverRouteLng = driverDecodedRoute[0].longitude;
    print('Decoded Route $driverDecodedRoute');
    read(startLocProvider).state = KapiotLocation(
      lat: driverRouteLat,
      lng: driverRouteLng,
    );
    print(read(startLocProvider).state);
  }

  Future<void> requestDriver(String driverId) async {
    final currentRouteConfig = read(currentRouteConfigProvider).state;
    assert(currentRouteConfig != null);
    // get driver's routeConfig using riderRepo
    // set a StateProvider
    // read state on map controller
    getDriverEncodedRoute(driverId);

    riderRepo.requestDriver(
      driverId,
      currentRouteConfig!,
    );
  }

  Stream<List<KapiotUser>> getCompatibleDrivers() =>
      riderRepo.getCompatibleDrivers();

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

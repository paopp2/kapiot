import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/view_model.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'request_accepted_map_controller.dart';

final requestAcceptedViewModel = Provider.autoDispose(
  (ref) => RequestAcceptedViewModel(
    read: ref.read,
    riderRepo: ref.watch(riderRepositoryProvider),
    currentUser: ref.watch(currentUserProvider),
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
    required this.googleMapsApiServices,
    required this.mapController,
  }) : super(read);
  final RiderRepository riderRepo;
  final KapiotUser? currentUser;
  final RequestAcceptedMapController mapController;
  final LocationService locationService;
  final GoogleMapsApiServices googleMapsApiServices;

  @override
  Future<void> initState() async {
    assert(read(acceptingDriverProvider).state != null);
    assert(currentUser != null);
    await mapController.initializeRequestAcceptedMap();
    final startLocation = read(startLocProvider).state;
    if (startLocation != null) {
      final currentPlace =
          await locationService.getAddressFromLocation(startLocation);
      read(startLocProvider).state =
          startLocation.copyWith(address: currentPlace);
    }
  }

  Stream<List<KapiotUser>> getCoRidersStream() {
    final acceptingDriver = read(acceptingDriverProvider).state;
    assert(acceptingDriver != null);
    return riderRepo.getCoRidersStream(
      currentUser: currentUser!,
      driver: acceptingDriver!,
    );
  }
}

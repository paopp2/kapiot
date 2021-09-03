import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/data/repositories/rider_repository.dart';
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
    assert(read(acceptingDriverConfigProvider).state != null);
    assert(currentUser != null);

    isDroppedOffStream().listen((isDroppedOff) {
      if (isDroppedOff) {
        print("Dropped off");
      }
    });

    await mapController.initializeRequestAcceptedMap();
    // This delay of arbitrary duration allows the map to finish initializing
    // before showing the acceptingDriver's route. Removing this delay seems to
    // result to a race condition. Should anyone have a better alternative to
    // this workaround, feel free to send a pull request
    await Future.delayed(const Duration(milliseconds: 50));
    mapController.showAcceptingDriverRoute();
  }

  /// Remaps the stream containing all riders that have been accepted by the
  /// current rider's acceptingDriver except for the current rider
  Stream<List<KapiotUser>> getMyCoRidersStream() {
    final acceptingDriverConfig = read(acceptingDriverConfigProvider).state!;
    final allCoRidersStream = riderRepo.getAllCoRidersStream(
      driver: acceptingDriverConfig.user,
    );
    return allCoRidersStream.map(
      (riderList) {
        return riderList
            .where((rider) => (rider.id != currentUser!.id))
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
    final allCoRidersStream = riderRepo.getAllCoRidersStream(
      driver: acceptingDriverConfig.user,
    );
    await for (var coRidersList in allCoRidersStream) {
      final hasRider = coRidersList.any(
        (rider) => (rider.id == currentUser!.id),
      );
      yield !hasRider;
    }
  }
}

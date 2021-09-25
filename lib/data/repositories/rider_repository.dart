import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/data/repositories/location_repository.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final riderRepositoryProvider = Provider.autoDispose((ref) => RiderRepository(
      firestoreHelper: FirestoreHelper.instance,
      locationRepo: ref.watch(locationRepositoryProvider),
      coreAlgorithms: ref.watch(coreAlgorithmsProvider),
    ));

class RiderRepository {
  RiderRepository({
    required this.firestoreHelper,
    required this.locationRepo,
    required this.coreAlgorithms,
  });
  final FirestoreHelper firestoreHelper;
  final LocationRepository locationRepo;
  final CoreAlgorithms coreAlgorithms;

  static final List<String> _driverIdList = [];

  void pushRiderConfig(RouteConfig riderConfig) async {
    assert(riderConfig is ForRider);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveRider(riderConfig.user.id),
      data: riderConfig.toJson(),
    );
  }

  Future<void> requestDriver(String driverId, RouteConfig riderConfig) async {
    assert(riderConfig is ForRider);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveDriverRequest(driverId, riderConfig.user.id),
      data: riderConfig.toJson(),
    );
    _driverIdList.add(driverId);
  }

  /// Deletes all other requests from a Driver's requests colection
  void deletePendingRequests(String riderId) {
    for (var driverId in _driverIdList) {
      firestoreHelper.deleteData(
          path: FirestorePath.docActiveDriverRequest(driverId, riderId));
    }
  }

  Stream<List<RouteConfig>> getCompatibleDriverConfigsAsStream(
    RouteConfig riderConfig,
  ) {
    final driverConfigsStream = firestoreHelper.collectionStream(
      path: FirestorePath.colActiveDrivers(),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    final driverLocsStream = locationRepo.getAllRealtimeLocations();
    return coreAlgorithms.getCompatibleDrivers(
      riderConfig: riderConfig,
      driverConfigsStream: driverConfigsStream,
      driverLocsStream: driverLocsStream,
    );
  }

  Stream<RouteConfig?> getAcceptingDriverConfigAsStream(String riderId) {
    final riderConfigStream = firestoreHelper.documentStream(
      path: FirestorePath.docActiveRider(riderId),
      builder: (data, id) => RouteConfig.fromJson(data),
    );
    // Remaps the rider's RouteConfig stream into a different stream only
    // emitting the 'acceptingDriver' field
    return riderConfigStream.map((riderConfig) {
      riderConfig as ForRider;
      return riderConfig.acceptingDriverConfig;
    });
  }

  /// Returns all riders that have been accepted by [driver]
  Stream<List<KapiotUser>> getAllCoRidersStream({
    required KapiotUser driver,
  }) {
    final acceptedRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colAcceptedRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return acceptedRidersConfigStream.map(
      (rcList) => rcList.map((rc) => rc.user).toList(),
    );
  }

  /// Returns all riders that have been accepted by [driver] as Stream of RouteConfigs
  Stream<List<RouteConfig>> getRiderConfigsStream({
    required KapiotUser driver,
  }) {
    final acceptedRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colAcceptedRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return acceptedRidersConfigStream;
  }
}

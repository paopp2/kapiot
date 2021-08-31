import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_algorithms.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final riderRepositoryProvider = Provider.autoDispose((ref) => RiderRepository(
      firestoreHelper: FirestoreHelper.instance,
      coreAlgorithms: ref.watch(coreAlgorithmsProvider),
    ));

class RiderRepository {
  RiderRepository({
    required this.firestoreHelper,
    required this.coreAlgorithms,
  });
  final FirestoreHelper firestoreHelper;
  final CoreAlgorithms coreAlgorithms;

  static final List<String> _driverIdList = [];

  void pushRiderConfig(RouteConfig routeConfig) async {
    assert(routeConfig is ForRider);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveRider(routeConfig.user.id),
      data: routeConfig.toJson(),
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
  ) async* {
    final allDriversStream = firestoreHelper.collectionStream(
      path: FirestorePath.colActiveDrivers(),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    await for (var driverConfigs in allDriversStream) {
      final compatibleDriversList = await coreAlgorithms.getCompatibleDrivers(
        riderConfig: riderConfig,
        driverConfigs: driverConfigs,
      );
      yield compatibleDriversList;
    }
  }

  Stream<RouteConfig?> getAcceptingDriverConfigAsStream(String riderId) {
    final riderConfigStream = firestoreHelper.documentStream(
      path: FirestorePath.docActiveRider(riderId),
      builder: (data, id) => RouteConfig.fromJson(data),
    );

    // Remaps the rider's RouteConfig stream into a different stream only
    // emitting the 'acceptingDriver' field
    return riderConfigStream.map((routeConfig) {
      // This 'maybeMap' is required in order to access the 'acceptingDriver'
      // property which is "ForRider" only
      return routeConfig.maybeMap(
        rider: (r) => r.acceptingDriverConfig,
        orElse: () => null,
      );
    });
  }

  Stream<List<KapiotUser>> getCoRidersStream({
    required KapiotUser driver,
    required KapiotUser currentUser,
  }) {
    final acceptedRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colAcceptedRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return acceptedRidersConfigStream.map((rcList) {
      final routeConfigListWithoutCurrentUser =
          rcList.where((rc) => rc.user.id != currentUser.id);
      return routeConfigListWithoutCurrentUser.map((rc) => rc.user).toList();
    });
  }
}

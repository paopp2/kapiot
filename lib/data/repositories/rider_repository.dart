import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final riderRepositoryProvider = Provider.autoDispose(
  (ref) => RiderRepository(firestoreHelper: FirestoreHelper.instance),
);

class RiderRepository {
  RiderRepository({required this.firestoreHelper});
  final FirestoreHelper firestoreHelper;

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

  // TODO: Kapiot algorithm here
  Stream<List<RouteConfig>> getCompatibleDriverConfigs() {
    return firestoreHelper.collectionStream(
      path: FirestorePath.colActiveDrivers(),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
  }

  Stream<KapiotUser?> getAcceptingDriverAsStream(String riderId) {
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
        rider: (r) => r.acceptingDriver,
        orElse: () => null,
      );
    });
  }

  // Alternative: Set the whole Driver's RouteConfig in the 'acceptingDriver'
  // field in a Rider's RouteConfig to be able to access the encoded route from
  // the method above
  Future<RouteConfig> getAcceptingDriverConfig(String driverId) {
    return firestoreHelper.getData(
      path: FirestorePath.docActiveDriver(driverId),
      builder: (data, id) => RouteConfig.fromJson(data),
    );
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

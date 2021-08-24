import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final driverRepositoryProvider = Provider.autoDispose(
  (ref) => DriverRepository(firestoreHelper: FirestoreHelper.instance),
);

class DriverRepository {
  DriverRepository({required this.firestoreHelper});
  final FirestoreHelper firestoreHelper;

  void pushDriverConfig(RouteConfig routeConfig) async {
    assert(routeConfig is ForDriver);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveDriver(routeConfig.user.id),
      data: routeConfig.toJson(),
    );
  }

  void acceptRider(String riderId, RouteConfig driverConfig) async {
    assert(driverConfig is ForDriver);
    final driver = driverConfig.user;
    final driverId = driver.id;
    final acceptedRiderConfig = await firestoreHelper.getData(
      path: FirestorePath.docActiveDriverRequest(driverId, riderId),
      builder: (data, id) => RouteConfig.fromJson(data),
    );
    await firestoreHelper.setData(
      path: FirestorePath.docActiveDriverAccepted(driverId, riderId),
      data: acceptedRiderConfig.toJson(),
    );
    await firestoreHelper.deleteData(
      path: FirestorePath.docActiveDriverRequest(driverId, riderId),
    );
    if (acceptedRiderConfig is ForRider) {
      await firestoreHelper.setData(
          path: FirestorePath.docActiveRider(acceptedRiderConfig.user.id),
          data: acceptedRiderConfig.copyWith(acceptingDriver: driver).toJson());
    } else {
      throw Exception("The received RouteConfig is not for Rider");
    }
  }

  Stream<List<KapiotUser>> getAcceptedRidersStream(KapiotUser driver) {
    final acceptedRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colAcceptedRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return acceptedRidersConfigStream
        .map((routeConfig) => routeConfig.map((rc) => rc.user).toList());
  }

  Stream<List<KapiotUser>> getRequestingRidersStream(KapiotUser driver) {
    final requestingRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colRequestingRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return requestingRidersConfigStream
        .map((routeConfig) => routeConfig.map((rc) => rc.user).toList());
  }
}

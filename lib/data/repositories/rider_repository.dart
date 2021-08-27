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

  static List<String> driverIdList = [];

  void pushRiderConfig(RouteConfig routeConfig) async {
    assert(routeConfig is ForRider);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveRider(routeConfig.user.id),
      data: routeConfig.toJson(),
    );
  }

  void requestDriver(String driverId, RouteConfig riderConfig) async {
    assert(riderConfig is ForRider);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveDriverRequest(driverId, riderConfig.user.id),
      data: riderConfig.toJson(),
    );
    driverIdList.add(driverId);
    print(driverIdList);
  }

  // TODO: Kapiot algorithm here
  Stream<List<KapiotUser>> getCompatibleDrivers() {
    final compatibleDriversConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colActiveDrivers(),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return compatibleDriversConfigStream
        .map((routeConfig) => routeConfig.map((rc) => rc.user).toList());
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
}

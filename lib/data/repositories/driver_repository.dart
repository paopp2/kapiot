import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

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
    await firestoreHelper.moveData(
      sourcePath: FirestorePath.docActiveDriverRequest(driverId, riderId),
      destPath: FirestorePath.docActiveDriverAccepted(driverId, riderId),
    );
    if (acceptedRiderConfig is ForRider) {
      await firestoreHelper.setData(
          path: FirestorePath.docActiveRider(acceptedRiderConfig.user.id),
          data: acceptedRiderConfig.copyWith(acceptingDriver: driver).toJson());
    } else {
      throw Exception("The received RouteConfig is not for Rider");
    }
  }

  Stream<List<StopPoint>> getStopPointsStream(KapiotUser driver) {
    final acceptedRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colAcceptedRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return acceptedRidersConfigStream.map<List<StopPoint>>((rcList) {
      // Splitting up a Rider's RouteConfig into two StopPoints, one for pickup
      // and one for drop off
      final List<StopPoint> unsortedStopPoints = rcList.expand<StopPoint>((rc) {
        // ForRider check is necessary in order to be able to access a rider's
        // startLoc and endLoc property
        assert(rc is ForRider);
        if (rc is ForRider) {
          final pickUpPoint = StopPoint(
            rider: rc.user,
            stopLocation: rc.startLocation,
            isPickUp: true,
          );
          final dropOffPoint = pickUpPoint.copyWith(
            stopLocation: rc.endLocation,
            isPickUp: false,
          );
          return [pickUpPoint, dropOffPoint];
        }
        throw Exception(
          "Error remapping acceptedRiderConfigs into StopPoints (config not ForRider)",
        );
      }).toList();
      // TODO: sort(unsortedStopPoints) according to driver's route
      return unsortedStopPoints;
    });
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

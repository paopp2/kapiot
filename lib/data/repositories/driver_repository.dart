import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_algorithms.dart';
import 'package:kapiot/data/helpers/firestore_helper.dart';
import 'package:kapiot/data/helpers/firestore_path.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';

final driverRepositoryProvider = Provider.autoDispose(
  (ref) => DriverRepository(
    firestoreHelper: FirestoreHelper.instance,
    coreAlgorithms: ref.watch(coreAlgorithmsProvider),
  ),
);

class DriverRepository {
  DriverRepository({
    required this.firestoreHelper,
    required this.coreAlgorithms,
  });
  final FirestoreHelper firestoreHelper;
  final CoreAlgorithms coreAlgorithms;

  void pushDriverConfig(RouteConfig driverConfig) async {
    assert(driverConfig is ForDriver);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveDriver(driverConfig.user.id),
      data: driverConfig.toJson(),
    );
  }

  void acceptRider(String riderId, RouteConfig driverConfig) async {
    assert(driverConfig is ForDriver);
    final driverId = driverConfig.user.id;
    final acceptedRiderConfig = await firestoreHelper.getData(
      path: FirestorePath.docActiveDriverRequest(driverId, riderId),
      builder: (data, id) => RouteConfig.fromJson(data),
    );
    await firestoreHelper.moveData(
      sourcePath: FirestorePath.docActiveDriverRequest(driverId, riderId),
      destPath: FirestorePath.docActiveDriverAccepted(driverId, riderId),
    );
    acceptedRiderConfig as ForRider;
    await firestoreHelper.setData(
        path: FirestorePath.docActiveRider(acceptedRiderConfig.user.id),
        data: acceptedRiderConfig
            .copyWith(acceptingDriverConfig: driverConfig)
            .toJson());
  }

  Future<void> removeRiderFromAccepted(String driverId, String riderId) async {
    firestoreHelper.deleteData(
      path: FirestorePath.docActiveDriverAccepted(driverId, riderId),
    );
  }

  Stream<List<StopPoint>> getStopPointsStream(RouteConfig driverConfig) async* {
    final driver = driverConfig.user;
    final acceptedRidersConfigStream = firestoreHelper.collectionStream(
      path: FirestorePath.colAcceptedRiders(driver.id),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    await for (var rcList in acceptedRidersConfigStream) {
      final List<StopPoint> unsortedStopPoints = rcList.expand<StopPoint>((rc) {
        rc as ForRider;
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
      }).toList();
      final sortedStopPoints = await coreAlgorithms.sortStopPoints(
        driverConfig: driverConfig,
        stopPoints: unsortedStopPoints,
      );
      yield sortedStopPoints;
    }
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

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

  // TODO: Kapiot algorithm here
  Stream<List<KapiotUser>> getCompatibleDrivers() {
    final compatibleDriversStream = firestoreHelper.collectionStream(
      path: FirestorePath.colActiveDrivers(),
      builder: (data, docID) => RouteConfig.fromJson(data),
    );
    return compatibleDriversStream
        .map((routeConfig) => routeConfig.map((rc) => rc.user).toList());
  }
}

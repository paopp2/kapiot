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

  void pushRiderConfig(RouteConfig routeConfig) async {
    assert(routeConfig is ForRider);
    await firestoreHelper.setData(
      path: FirestorePath.docActiveRider(routeConfig.user.id),
      data: routeConfig.toJson(),
    );
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

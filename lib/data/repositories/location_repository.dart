import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/realtime_db_helper.dart';
import 'package:kapiot/data/helpers/realtime_db_path.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final locationRepositoryProvider = Provider.autoDispose(
  (ref) => LocationRepository(
    realtimeDbHelper: RealtimeDbHelper.instance,
  ),
);

class LocationRepository {
  LocationRepository({required this.realtimeDbHelper});
  final RealtimeDbHelper realtimeDbHelper;

  Future<void> updateLocation(String userId, KapiotLocation location) async {
    realtimeDbHelper.setData(
      path: RealtimeDbPath.userRealtimeLocation(userId),
      data: location.toJson(),
    );
  }

  Stream<KapiotLocation> getRealtimeLocation(String userId) {
    return realtimeDbHelper.documentStream(
      path: RealtimeDbPath.userRealtimeLocation(userId),
      builder: (data) => KapiotLocation.fromJson(data),
    );
  }

  Stream<List<Map<String, KapiotLocation>>> getAllRealtimeLocations() {
    return realtimeDbHelper.collectionStream(
      path: RealtimeDbPath.allRealtimeLocations(),
      builder: (data, id) => {id: KapiotLocation.fromJson(data)},
    );
  }
}

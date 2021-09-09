import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/helpers/realtime_db_helper.dart';

final locationRepository = Provider.autoDispose(
  (ref) => LocationRepository(
    realtimeDbHelper: RealtimeDbHelper.instance,
  ),
);

class LocationRepository {
  LocationRepository({required this.realtimeDbHelper});
  final RealtimeDbHelper realtimeDbHelper;
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final compatibleDriverConfigStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(requestDriversViewModel).getCompatibleDriverConfigs(),
);

final driverStartLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

final driverEndLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';

final compatibleDriverConfigStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(requestDriversViewModel).getCompatibleDriverConfigs(),
);

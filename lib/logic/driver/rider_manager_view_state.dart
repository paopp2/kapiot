import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';

final acceptedRidersStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(riderManagerViewModel).getAcceptedRidersStream(),
);

final requestingRidersStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(riderManagerViewModel).getRequestingRidersStream(),
);

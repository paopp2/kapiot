import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';

final coRiderConfigsStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(requestAcceptedViewModel).getMyCoRiderConfigsStream(),
);

final coRiderCountProvider = Provider.autoDispose<int>((ref) {
  ref.watch(coRiderConfigsStreamProvider.stream).listen((rcList) {
    ref.state = rcList.length;
  });
  return 0;
});

final estArrivalTimeProvider =
    StateProvider.autoDispose<String>((ref) => '...');

final hasPickedUpRiderProvider =
    StateProvider.autoDispose<bool>((ref) => false);

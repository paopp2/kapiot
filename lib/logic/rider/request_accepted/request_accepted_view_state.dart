import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';

final coRiderConfigsStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(requestAcceptedViewModel).getMyCoRiderConfigsStream(),
);

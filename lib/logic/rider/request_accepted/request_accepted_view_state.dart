import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final startLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

final coRidersStreamProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(requestAcceptedViewModel).getCoRidersStream(),
);

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final locationToSaveProvider = StateProvider.autoDispose<KapiotLocation?>(
  (ref) {
    ref.maintainState = true;
    return null;
  },
);

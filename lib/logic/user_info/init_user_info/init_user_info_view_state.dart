import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final userTypeProvider = StateProvider.autoDispose<UserType>(
  (ref) => UserType.student,
);

final pageIndexProvider = StateProvider((ref) => 0);

final isForHomeLocProvider = StateProvider.autoDispose<bool>((ref) => true);

final homeFieldTextProvider = StateProvider.autoDispose<String?>((ref) => null);
final nonHomeFieldTextProvider =
    StateProvider.autoDispose<String?>((ref) => null);

final savedLocationsProvider =
    StateProvider<Map<String, KapiotLocation>>((ref) => {});

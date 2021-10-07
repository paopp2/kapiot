import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final userTypeProvider = StateProvider.autoDispose<UserType>(
  (ref) => UserType.student,
);

final pageIndexProvider = StateProvider((ref) {
  Future.delayed(Duration.zero, () => ref.controller.state = 1);
  Future.delayed(const Duration(seconds: 3), () => ref.controller.state = 2);
  return 0;
});

final isForHomeLocProvider = StateProvider.autoDispose<bool>((ref) => true);

final placeSuggestionsProvider =
    StateProvider.autoDispose<List<String?>>((ref) => []);

final homeLocProvider = StateProvider<KapiotLocation?>((ref) => null);

final schoolLocProvider = StateProvider<KapiotLocation?>((ref) => null);

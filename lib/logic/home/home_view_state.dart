import 'package:hooks_riverpod/hooks_riverpod.dart';

final isRiderProvider = StateProvider.autoDispose<bool>((ref) => true);

final riderCountProvider = StateProvider.autoDispose<int>((ref) => 1);

final dateTimeProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

final isStartLocFocusedProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final isEndLocFocusedProvider = StateProvider.autoDispose<bool>((ref) => false);

final placeSuggestionsProvider =
    StateProvider.autoDispose<List<String?>>((ref) => []);

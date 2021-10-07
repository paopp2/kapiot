import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final userTypeProvider = StateProvider.autoDispose<UserType?>((ref) => null);

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final startLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

final coRidersListProvider =
    StateProvider.autoDispose<List<KapiotUser>>((ref) => []);

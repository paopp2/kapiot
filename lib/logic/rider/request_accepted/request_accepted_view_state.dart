import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final startLocProvider =
    StateProvider.autoDispose<KapiotLocation?>((ref) => null);

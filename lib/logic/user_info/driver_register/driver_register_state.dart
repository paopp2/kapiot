import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/car/car.dart';

final carTypeProvider = StateProvider.autoDispose<CarType?>((ref) => null);

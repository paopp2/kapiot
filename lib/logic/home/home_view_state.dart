import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final startLocationProvider =
    StateProvider.autoDispose<Position?>((ref) => null);

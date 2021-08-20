import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentLocationProvider =
    StateProvider.autoDispose<Position?>((ref) => null);

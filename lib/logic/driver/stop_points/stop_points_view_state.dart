import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cameraPositionProvider =
    StateProvider.autoDispose<CameraPosition?>((ref) => null);

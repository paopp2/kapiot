import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/home/home_map_controller.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

final homeViewModelProvider = Provider.autoDispose(
  (ref) => HomeViewModel(
    read: ref.read,
    authService: ref.watch(authServiceProvider),
    mapController: HomeMapController(
      read: ref.read,
      locationService: ref.watch(locationServiceProvider),
    ),
  ),
);

class HomeViewModel {
  HomeViewModel({
    required this.read,
    required this.authService,
    required this.mapController,
  });
  final Reader read;
  final AuthService authService;
  final HomeMapController mapController;
  late final CameraPosition initialCameraPosition;

  Future<void> initState() async {
    await mapController.initializeMap();
  }

  Future<void> signOut() async => await authService.signOutGoogle();

  void toggleIsRider(bool valueHasChanged) {
    if (valueHasChanged) {
      final currentIsRider = read(isRiderSelectedProvider).state;
      read(isRiderSelectedProvider).state = !currentIsRider;
    }
  }

  void incRiderCount() => read(riderCountProvider).state++;

  void decRiderCount() {
    if (read(riderCountProvider).state > 1) {
      read(riderCountProvider).state--;
    }
  }

  void dispose() {}
}

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/auth_service.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

final homeViewModelProvider = Provider.autoDispose(
  (ref) => HomeViewModel(
    read: ref.read,
    locationService: ref.watch(locationServiceProvider),
    authService: ref.watch(authServiceProvider),
  ),
);

class HomeViewModel {
  HomeViewModel({
    required this.read,
    required this.locationService,
    required this.authService,
  });
  final Reader read;
  final LocationService locationService;
  final AuthService authService;
  late final CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> initState() async {
    final currentLoc = await locationService.getLocation();
    read(currentLocationProvider).state = currentLoc;
    initialCameraPosition = CameraPosition(
      target: LatLng(currentLoc.latitude, currentLoc.longitude),
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
  }

  void onMapCreated(GoogleMapController gmapController) =>
      _controller.complete(gmapController);

  Future<void> signOut() async => await authService.signOutGoogle();

  Future<void> gotoLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void dispose() {}
}

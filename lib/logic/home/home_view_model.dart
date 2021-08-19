import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

final homeViewModelProvider = Provider.autoDispose(
  (ref) => HomeViewModel(
    read: ref.read,
    locationService: ref.watch(locationServiceProvider),
  ),
);

class HomeViewModel {
  HomeViewModel({
    required this.read,
    required this.locationService,
  });
  final Reader read;
  final LocationService locationService;
  final Completer<GoogleMapController> _controller = Completer();
  late final CameraPosition initialPosition;

  static const CameraPosition gwapoHouse = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(10.367836951212034, 123.91396789976241),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> initState() async {
    final currentLoc = await locationService.getLocation();
    read(startLocationProvider).state = currentLoc;
    initialPosition = CameraPosition(
      target: LatLng(currentLoc.latitude, currentLoc.longitude),
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
  }

  void dispose() {}

  void onMapCreated(GoogleMapController gmapController) =>
      _controller.complete(gmapController);

  Future<void> goToGwapoHouse() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(gwapoHouse));
  }
}

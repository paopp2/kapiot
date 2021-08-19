import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModel = Provider.autoDispose((ref) => HomeViewModel(ref.read));

class HomeViewModel {
  HomeViewModel(this.read);
  final Reader read;

  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(10.367836951212034, 123.91396789976241),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void onMapCreated(GoogleMapController gmapController) =>
      _controller.complete(gmapController);

  Future<void> goToLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(kLake));
  }
}

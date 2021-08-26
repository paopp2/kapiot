import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/view_model.dart';

final stopPointsViewModel = Provider.autoDispose<StopPointsViewModel>(
    (ref) => StopPointsViewModel(ref.read));

class StopPointsViewModel extends ViewModel {
  StopPointsViewModel(Reader read) : super(read);
  final Completer<GoogleMapController> _controller = Completer();
  final CameraPosition lake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void onMapCreated(GoogleMapController gmapController) =>
      _controller.complete(gmapController);
}

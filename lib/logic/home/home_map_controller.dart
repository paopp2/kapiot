import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/location_service.dart';
import 'home_view_state.dart';

// TODO: Exposed API key! Hide in production
const googleApiKey = "AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI";

class HomeMapController {
  HomeMapController({
    required this.read,
    required this.locationService,
  });
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final Completer<GoogleMapController> _controller = Completer();
  final Reader read;
  final LocationService locationService;

  Future<void> initializeMap() async {
    final currentLoc = await locationService.getLocation();
    read(cameraPositionProvider).state = CameraPosition(
      target: LatLng(currentLoc.latitude, currentLoc.longitude),
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
  }

  void setMapPins(LatLng source, LatLng destination) {
    Set<Marker> _markers = {};
    // source pin
    _markers.add(Marker(markerId: MarkerId('sourcePin'), position: source));
    // destination pin
    _markers.add(Marker(markerId: MarkerId('destPin'), position: destination));
    read(sourceAndDestMarkersProvider).state = _markers;
  }

  void onMapCreated(GoogleMapController gmapController) =>
      _controller.complete(gmapController);

  Future<void> gotoLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

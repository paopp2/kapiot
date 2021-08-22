import 'dart:async';
import 'package:flutter/material.dart';
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
  final Completer<GoogleMapController> _controller = Completer();
  final Reader read;
  final LocationService locationService;
  final PolylinePoints polylinePoints = PolylinePoints();

  //! TEMPORARY VALUES
  final sourceLocation = const LatLng(37.43296265331129, -122.08832357078792);
  final destLocation = const LatLng(37.423395, -122.072706);

  Future<void> initializeMap() async {
    var temp = await locationService.getLocation();
    const currentLoc = LatLng(37.43296265331129, -122.08832357078792);
    read(cameraPositionProvider).state = CameraPosition(
      target: LatLng(currentLoc.latitude, currentLoc.longitude),
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
  }

  void setMapPins() {
    Set<Marker> _markers = {};
    // source pin
    _markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: sourceLocation,
        icon: BitmapDescriptor.defaultMarker));
    // destination pin
    _markers.add(Marker(
        markerId: const MarkerId('destPin'),
        position: destLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(90)));
    read(sourceAndDestMarkersProvider).state = _markers;
  }

  Future<void> getPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destLocation.latitude, destLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = [];
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      addPolyline(polylineCoordinates);
    }
  }

  void addPolyline(List<LatLng> polylineCoordinates) {
    final polylines = read(polylinesProvider).state;
    Polyline polyline = Polyline(
      polylineId: const PolylineId("poly"),
      color: Colors.red,
      points: polylineCoordinates,
    );
    polylines.add(polyline);
    read(polylinesProvider).state = polylines;
  }

  void onMapCreated(GoogleMapController gmapController) async {
    _controller.complete(gmapController);
    // ! TEMPORARY call
    setMapPins();
    await getPolylines();
  }
}

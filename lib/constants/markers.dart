import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  Markers._();
  static final instance = Markers._();
  static late final Marker startLoc;
  static late final Marker endLoc;
  static late final Marker currentUserLoc;

  static final driverLoc = Marker(
    markerId: const MarkerId('driver_loc_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  );

  static final riderEndLoc = Marker(
    markerId: const MarkerId('rider_loc_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
  );

  static final nextStopPoint = Marker(
    markerId: const MarkerId('next_stop_point'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  );

  Future<void> initMarkers() async {
    String basePath = 'assets/icons/markers';
    startLoc = await _setupMarker(
      path: '$basePath/startLoc.png',
      id: 'start_loc_marker',
    );
    currentUserLoc = await _setupMarker(
      path: '$basePath/currentLoc.png',
      id: 'current_user_marker',
    );
    endLoc = await _setupMarker(
      path: '$basePath/endLoc.png',
      id: 'end_loc_marker',
    );
  }

  Future<Marker> _setupMarker({
    required String path,
    required String id,
  }) async {
    final icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      path,
    );
    return Marker(
      anchor: const Offset(0.5, 0.5),
      markerId: MarkerId(id),
      icon: icon,
    );
  }
}

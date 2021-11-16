import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  Markers._();
  static final instance = Markers._();
  static late final Marker startLoc;
  static late final Marker endLoc;
  static late final Marker currentUserLoc;
  static late final Marker driverLoc;
  static late final Marker riderEndLoc;
  static late final Marker nextStopPoint;
  static late final Marker pickupPoint;
  static late final Marker dropoffPoint;

  Future<Marker> _setupMarker({
    required String iconPath,
    required String id,
    Offset anchor = const Offset(0.5, 0.5),
  }) async {
    return Marker(
      anchor: anchor,
      markerId: MarkerId(id),
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        iconPath,
      ),
    );
  }

  Future<void> initMarkers() async {
    String basePath = 'assets/icons/markers';
    startLoc = await _setupMarker(
      anchor: const Offset(0.5, 1.0),
      iconPath: '$basePath/startLoc.png',
      id: 'start_loc_marker',
    );
    currentUserLoc = await _setupMarker(
      iconPath: '$basePath/currentLoc.png',
      id: 'current_user_marker',
    );
    endLoc = await _setupMarker(
      anchor: const Offset(0.5, 1.0),
      iconPath: '$basePath/endLoc.png',
      id: 'end_loc_marker',
    );
    driverLoc = await _setupMarker(
      iconPath: '$basePath/driverLoc.png',
      id: 'driver_loc_marker',
    );
    riderEndLoc = await _setupMarker(
      iconPath: '$basePath/endLoc.png',
      id: 'rider_loc_marker',
    );
    nextStopPoint = await _setupMarker(
      anchor: const Offset(0.5, 1.0),
      iconPath: '$basePath/stopPoint.png',
      id: 'next_stop_point',
    );
    pickupPoint = await _setupMarker(
      anchor: const Offset(0.5, 1.0),
      iconPath: '$basePath/pickupPoint.png',
      id: 'next_stop_point',
    );
    dropoffPoint = await _setupMarker(
      anchor: const Offset(0.5, 1.0),
      iconPath: '$basePath/dropoffPoint.png',
      id: 'next_stop_point',
    );
  }
}

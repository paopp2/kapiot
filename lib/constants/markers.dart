import 'package:google_maps_flutter/google_maps_flutter.dart';

class Markers {
  static final startLoc = Marker(
    markerId: const MarkerId('start_loc_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  );

  static final endLoc = Marker(
    markerId: const MarkerId('end_loc_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
  );

  static final driverLoc = Marker(
    markerId: const MarkerId('driver_loc_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  );

  static final riderEndLoc = Marker(
    markerId: const MarkerId('rider_loc_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
  );

  static final currentUserLoc = Marker(
    markerId: const MarkerId('current_user_marker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
  );

  static Marker stopPoint(String id) {
    return Marker(
      markerId: MarkerId('StopPoint: $id'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );
  }
}

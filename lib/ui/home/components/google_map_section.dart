import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

import 'loading_screen.dart';

class GoogleMapSection extends StatelessWidget {
  const GoogleMapSection({
    required this.model,
    required this.camPosition,
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;
  final CameraPosition? camPosition;

  @override
  Widget build(BuildContext context) {
    return (camPosition == null)
        ? const LoadingScreen(text: "Fetching current location...")
        : GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: camPosition!,
            onMapCreated: model.onMapCreated,
          );
  }
}

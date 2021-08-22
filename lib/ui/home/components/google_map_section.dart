import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

import 'loading_screen.dart';

class GoogleMapSection extends HookConsumerWidget {
  const GoogleMapSection({
    required this.model,
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camPosition = ref.watch(cameraPositionProvider).state;
    final markers = ref.watch(sourceAndDestMarkersProvider).state;
    final polylines = ref.watch(polylinesProvider).state;
    return (camPosition == null)
        ? const LoadingScreen(text: "Fetching current location...")
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: camPosition,
            onMapCreated: model.mapController.onMapCreated,
            markers: markers,
            polylines: polylines,
          );
  }
}

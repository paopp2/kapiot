import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

import 'loading_screen.dart';

class HomeViewMap extends HookConsumerWidget {
  const HomeViewMap({
    required this.model,
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startLocation = ref.watch(startLocProvider).state;
    final markers = ref.watch(startEndMarkersProvider).state;
    final polylines = ref.watch(polylinesProvider).state;
    return (startLocation == null)
        ? const LoadingScreen(text: "Fetching current location...")
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: model.mapController.initialCameraPosition,
            onMapCreated: model.mapController.onMapCreated,
            markers: markers,
            polylines: polylines,
          );
  }
}

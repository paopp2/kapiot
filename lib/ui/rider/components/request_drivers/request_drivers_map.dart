import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/rider/request_drivers_view_model.dart';
import 'package:kapiot/ui/home/components/loading_screen.dart';

class RequestDriversViewMap extends HookConsumerWidget {
  const RequestDriversViewMap({
    required this.model,
    Key? key,
  }) : super(key: key);

  final RequestDriversViewModel model;

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

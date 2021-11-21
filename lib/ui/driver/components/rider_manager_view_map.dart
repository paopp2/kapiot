import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_map_controller.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

class RiderManagerViewMap extends HookConsumerWidget {
  const RiderManagerViewMap({
    required this.model,
    Key? key,
  }) : super(key: key);

  final RiderManagerViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startLocation = ref.watch(startLocProvider);
    final mapController = ref.watch(riderManagerMapController);
    final markers = ref.watch(markersProvider);
    final polylines = ref.watch(polylinesProvider);
    return (startLocation == null)
        ? const LoadingWidget(text: "Initializing map...")
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: mapController.initialCameraPosition,
            onMapCreated: mapController.onMapCreated,
            zoomControlsEnabled: false,
            markers: markers,
            polylines: polylines,
          );
  }
}

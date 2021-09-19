import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_map_controller.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

class RequestDriversViewMap extends HookConsumerWidget {
  const RequestDriversViewMap({
    required this.model,
    Key? key,
  }) : super(key: key);

  final RequestDriversViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startLocation = ref.watch(startLocProvider).state;
    final mapController = ref.watch(requestDriversMapController);
    final markers = ref.watch(markersProvider).state;
    final polylines = ref.watch(polylinesProvider).state;
    return (startLocation == null)
        ? const LoadingWidget(text: "Initializing map...")
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: mapController.initialCameraPosition,
            onMapCreated: mapController.onMapCreated,
            markers: markers,
            polylines: polylines,
          );
  }
}

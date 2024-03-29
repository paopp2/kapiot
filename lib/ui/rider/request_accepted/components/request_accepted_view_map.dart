import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_map_controller.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

class RequestAcceptedViewMap extends HookConsumerWidget {
  const RequestAcceptedViewMap({
    required this.model,
    Key? key,
  }) : super(key: key);

  final RequestAcceptedViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startLocation = ref.watch(startLocProvider);
    final mapController = ref.watch(requestAcceptedMapController);
    final markers = ref.watch(markersProvider);
    final polylines = ref.watch(polylinesProvider);
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

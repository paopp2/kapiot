import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/stop_points_view_model.dart';

class StopPointsView extends HookConsumerWidget {
  const StopPointsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(stopPointsViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("Back to RiderManager"),
            icon: const Icon(Icons.arrow_back),
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: model.lake,
            onMapCreated: model.onMapCreated,
          ),
        );
      },
    );
  }
}

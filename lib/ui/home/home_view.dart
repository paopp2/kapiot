import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: model.kGooglePlex,
            onMapCreated: model.onMapCreated,
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: model.goToLake,
            label: const Text('Balay sa gwapo 😎'),
          ),
        );
      },
    );
  }
}

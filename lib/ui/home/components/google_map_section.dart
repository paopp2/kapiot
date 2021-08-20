import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

class GoogleMapSection extends HookConsumerWidget {
  const GoogleMapSection(
    this.model, {
    Key? key,
  }) : super(key: key);
  final HomeViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModelProvider);

    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: model.initialCameraPosition,
      onMapCreated: model.onMapCreated,
    );
  }
}

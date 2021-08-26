import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_state.dart';

import 'driver_card.dart';

class DriverCardStream extends HookConsumerWidget {
  const DriverCardStream({
    Key? key,
    required this.model,
  }) : super(key: key);

  final RequestDriversViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compatibleDriversStream = ref.watch(compatibleDriversStreamProvider);
    return Builder(builder: (context) {
      return compatibleDriversStream.when(
        error: (_, __) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (compatibleDrivers) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: compatibleDrivers.length,
          itemBuilder: (context, index) {
            final driver = compatibleDrivers[index];
            return DriverCard(driver: driver, model: model);
          },
        ),
      );
    });
  }
}

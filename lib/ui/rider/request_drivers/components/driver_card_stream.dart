import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_state.dart';
import 'package:kapiot/model/route_config/route_config.dart';

import 'driver_card.dart';

class DriverCardStream extends HookConsumerWidget {
  const DriverCardStream(
      {Key? key, required this.model, required this.constraints})
      : super(key: key);

  final RequestDriversViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compatibleDriverConfigStream =
        ref.watch(compatibleDriverConfigStreamProvider);
    return Builder(builder: (context) {
      return compatibleDriverConfigStream.when(
        error: (_, __) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (compatibleDriverConfigs) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: compatibleDriverConfigs.length,
            itemBuilder: (context, index) {
              final driverConfig = compatibleDriverConfigs[index];
              return DriverCard(
                driverConfig: driverConfig as ForDriver,
                model: model,
                constraints: constraints,
                index: index,
              );
            },
          );
        },
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

import 'driver_card.dart';

class DriverStream extends StatelessWidget {
  const DriverStream({
    Key? key,
    required this.compatibleDriversStream,
    required this.model,
  }) : super(key: key);

  final AsyncValue<List<KapiotUser>> compatibleDriversStream;
  final RequestDriversViewModel model;

  @override
  Widget build(BuildContext context) {
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

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver_register/driver_register_view_model.dart';
import 'package:kapiot/model/car/car.dart';

// TODO: Move to relative 'components' directory
class VehicleType extends StatelessWidget {
  VehicleType(
      {Key? key,
      required this.constraints,
      required this.vehicleIcon,
      required this.vehicleLabel,
      required this.model,
      required this.carType})
      : super(key: key);

  final BoxConstraints constraints;
  final Icon vehicleIcon;
  final String vehicleLabel;
  final CarType carType;
  final DriverRegisterViewModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        model.setCarType(carType);
        print(carType);
        print('highlight ' + vehicleLabel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.025,
        ),
        height: constraints.maxWidth * 0.3,
        width: constraints.maxWidth * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vehicleIcon,
            Text(vehicleLabel),
          ],
        ),
      ),
    );
  }
}

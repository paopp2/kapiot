import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/user_info/driver_register/driver_register_state.dart';
import 'package:kapiot/logic/user_info/driver_register/driver_register_view_model.dart';
import 'package:kapiot/model/car/car.dart';

class VehicleType extends HookConsumerWidget {
  const VehicleType({
    Key? key,
    required this.constraints,
    required this.vehicleIcon,
    required this.vehicleLabel,
    required this.model,
    required this.carType,
  }) : super(key: key);

  final BoxConstraints constraints;
  final Icon vehicleIcon;
  final String vehicleLabel;
  final CarType carType;
  final DriverRegisterViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCarType = ref.watch(carTypeProvider).state;
    final isSelected = (selectedCarType == carType);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.025,
      ),
      height: constraints.maxWidth * 0.3,
      width: constraints.maxWidth * 0.3,
      child: ElevatedButton(
        onPressed: () => model.setCarType(carType),
        style: ElevatedButton.styleFrom(
          primary: (isSelected) ? Colors.purple[200] : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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

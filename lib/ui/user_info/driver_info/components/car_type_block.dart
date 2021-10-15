import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/user_info/driver_info/car_register_state.dart';
import 'package:kapiot/logic/user_info/driver_info/car_register_view_model.dart';
import 'package:kapiot/model/car/car.dart';

class CarTypeBlock extends HookConsumerWidget {
  const CarTypeBlock({
    Key? key,
    required this.constraints,
    required this.model,
    required this.carType,
  }) : super(key: key);

  final BoxConstraints constraints;
  final CarType carType;
  final CarRegisterViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCarType = ref.watch(carTypeProvider).state;
    final isSelected = (selectedCarType == carType);
    return SizedBox(
      height: constraints.maxWidth * 0.3,
      width: constraints.maxWidth,
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
            carType.icon,
            Text(carType.label),
            Text("${carType.capacity}-seater"),
          ],
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/user_info/driver_info/car_register_state.dart';
import 'package:kapiot/logic/user_info/driver_info/car_register_view_model.dart';
import 'package:kapiot/model/car/car.dart';

class CarTypeBlock extends HookConsumerWidget {
  const CarTypeBlock({
    Key? key,
    required this.constraints,
    required this.controller,
    required this.model,
    required this.carType,
    required this.index,
  }) : super(key: key);

  final BoxConstraints constraints;
  final CarouselController controller;
  final CarType carType;
  final CarRegisterViewModel model;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCarType = ref.watch(carTypeProvider).state;
    final isSelected = (selectedCarType == carType);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isSelected
              ? [
                  const Color(0xffdbb3d4),
                  const Color(0xffe9d1e5),
                  const Color(0xffffffff),
                  const Color(0xffe9d1e5),
                  const Color(0xffaf8fa9),
                ]
              : [
                  const Color(0xffeeeeee),
                  const Color(0xffffffff),
                  const Color(0xffa6a6a6),
                ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 200,
      width: constraints.maxWidth,
      child: ElevatedButton(
        onPressed: () {
          model.setCarType(carType);
          controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: carType.icon,
              height: 110,
            ),
            Text(
              carType.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : const Color(0xff333333),
              ),
            ),
            Text(
              "${carType.capacity}-seater",
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xff666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

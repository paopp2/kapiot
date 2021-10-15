import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/user_info/driver_info/car_register_view_model.dart';
import 'package:kapiot/model/car/car.dart';

import 'components/car_type_block.dart';

class CarRegisterView extends HookConsumerWidget {
  const CarRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(carRegisterViewModel);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: AppRouter.instance.popView,
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.blue,
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: constraints.maxWidth,
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.025,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('License Plate'),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: model.licensePlateKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.03,
                              ),
                              hintText: 'ABC 123',
                              border: const OutlineInputBorder(),
                            ),
                            controller: model.tecLicensePlateField,
                            validator: model.carRegisterValidator,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.1,
                    width: constraints.maxWidth,
                    margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.025,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.025,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Make'),
                              const SizedBox(
                                height: 10,
                              ),
                              Form(
                                key: model.carMakeKey,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: model.tecCarMakeField,
                                    validator: model.carRegisterValidator,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03,
                                      ),
                                      hintText: 'Toyota',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: constraints.maxWidth * 0.5,
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.025,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Model'),
                              const SizedBox(
                                height: 10,
                              ),
                              Form(
                                key: model.carModelKey,
                                child: Expanded(
                                  child: TextFormField(
                                    controller: model.tecCarModelField,
                                    validator: model.carRegisterValidator,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03,
                                      ),
                                      hintText: 'Vios',
                                      border: const OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth,
                    margin: EdgeInsets.only(top: constraints.maxHeight * 0.025),
                    child: Column(
                      children: [
                        const Text('Vehicle Type'),
                        const SizedBox(
                          height: 10,
                        ),
                        CarouselSlider.builder(
                          itemCount: CarType.values.length,
                          options: CarouselOptions(
                            height: constraints.maxHeight * 0.25,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.5,
                            initialPage: 0,
                            onPageChanged: (index, _) {
                              model.setCarType(CarType.values[index]);
                            },
                          ),
                          itemBuilder: (context, index, _) {
                            final carType = CarType.values[index];
                            return CarTypeBlock(
                              constraints: constraints,
                              carType: carType,
                              model: model,
                            );
                          },
                        ),

                        // [
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Coupe',
                        //     seats: '2/4',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Sedan',
                        //     seats: '5',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Hatchback',
                        //     seats: '5',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Pickup',
                        //     seats: '5',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'SUV',
                        //     seats: '7',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'MPV',
                        //     seats: '7',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Wagon',
                        //     seats: '7',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Multicab',
                        //     seats: '11-13',
                        //   ),
                        //   VehicleType(
                        //     constraints: constraints,
                        //     vehicleIcon: Icon(Icons.car_rental),
                        //     vehicleLabel: 'Van/Minivan',
                        //     seats: '8-15',
                        //   ),
                        // ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 69),
                  ElevatedButton(
                    onPressed: model.registerCar,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// class VehicleType extends HookConsumerWidget {
//   const VehicleType({
//     Key? key,
//     required this.constraints,
//     required this.vehicleIcon,
//     required this.vehicleLabel,
//     required this.seats,
//     required this.carType,
//     required this.isSelected,
//   }) : super(key: key);

//   final BoxConstraints constraints;
//   final Icon vehicleIcon;
//   final String vehicleLabel;
//   final CarType carType;
//   final String seats;
//   final bool isSelected;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final selectedCarType = ref.watch(carTypeProvider).state;
//     // final isSelected = (selectedCarType == carType);
//     return Container(
//       width: constraints.maxWidth * 0.5,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: (isSelected) ? Colors.purple[200] : Colors.grey[200],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           vehicleIcon,
//           Text(vehicleLabel),
//           Text(seats + ' seater'),
//         ],
//       ),
//     );
//   }
// }

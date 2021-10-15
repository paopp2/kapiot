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
    final carTypes = [
      [Icon(Icons.car_rental), 'Coupe', '2/4'],
      [Icon(Icons.car_rental), 'Sedan', '5'],
      [Icon(Icons.car_rental), 'Hatchback', '5'],
      [Icon(Icons.car_rental), 'Pickup', '5'],
      [Icon(Icons.car_rental), 'SUV', '7'],
      [Icon(Icons.car_rental), 'MPV', '7'],
      [Icon(Icons.car_rental), 'Wagon', '7'],
      [Icon(Icons.car_rental), 'Multicab', '11-13'],
      [Icon(Icons.car_rental), 'Van/Minivan', '8-15'],
    ];

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
                              border: OutlineInputBorder(),
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
                                      border: OutlineInputBorder(),
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
                                      border: OutlineInputBorder(),
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
                          itemCount: carTypes.length,
                          options: CarouselOptions(
                            height: constraints.maxHeight * 0.25,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.5,
                            initialPage: 0,
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final carTypeIcon = carTypes[index][0] as Icon;
                            final carTypeName = carTypes[index][1] as String;
                            final carTypeCapacity =
                                carTypes[index][2] as String;
                            return VehicleType(
                                constraints: constraints,
                                vehicleIcon: carTypeIcon,
                                vehicleLabel: carTypeName,
                                seats: carTypeCapacity);
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
                  // Container(
                  //   width: constraints.maxWidth,
                  //   margin: EdgeInsets.only(top: constraints.maxHeight * 0.025),
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         CarTypeBlock(
                  //           constraints: constraints,
                  //           vehicleIcon: const Icon(Icons.car_rental),
                  //           vehicleLabel: 'Sedan',
                  //           carType: CarType.sedan,
                  //           model: model,
                  //         ),
                  //         CarTypeBlock(
                  //           constraints: constraints,
                  //           vehicleIcon: const Icon(Icons.car_rental),
                  //           vehicleLabel: 'Hatchback',
                  //           carType: CarType.hatchback,
                  //           model: model,
                  //         ),
                  //         CarTypeBlock(
                  //           constraints: constraints,
                  //           vehicleIcon: const Icon(Icons.car_rental),
                  //           vehicleLabel: 'Truck',
                  //           carType: CarType.truck,
                  //           model: model,
                  //         ),
                  //         CarTypeBlock(
                  //           constraints: constraints,
                  //           vehicleIcon: const Icon(Icons.car_rental),
                  //           vehicleLabel: 'SUV',
                  //           carType: CarType.suv,
                  //           model: model,
                  //         ),
                  //         CarTypeBlock(
                  //           constraints: constraints,
                  //           vehicleIcon: const Icon(Icons.car_rental),
                  //           vehicleLabel: 'AUV',
                  //           carType: CarType.auv,
                  //           model: model,
                  //         ),
                  //         CarTypeBlock(
                  //           constraints: constraints,
                  //           vehicleIcon: const Icon(Icons.car_rental),
                  //           vehicleLabel: 'Van',
                  //           carType: CarType.van,
                  //           model: model,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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

class VehicleType extends StatelessWidget {
  VehicleType({
    Key? key,
    required this.constraints,
    required this.vehicleIcon,
    required this.vehicleLabel,
    required this.seats,
  }) : super(key: key);

  BoxConstraints constraints;
  Icon vehicleIcon;
  String vehicleLabel;
  String seats;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.purple[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          vehicleIcon,
          Text(vehicleLabel),
          Text(seats + ' seater'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/user_info/driver_register/driver_register_view_model.dart';
import 'package:kapiot/model/car/car.dart';
import 'components/car_type_block.dart';

class DriverRegisterView extends HookConsumerWidget {
  const DriverRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(driverRegisterViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: model.licensePlateKey,
                  child: TextFormField(
                    controller: model.tecLicensePlateField,
                    validator: model.driverRegisterValidator,
                    decoration: const InputDecoration(
                        hintText: 'License plate (eg. FAG 134)'),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  width: constraints.maxWidth,
                  child: Row(
                    children: [
                      Form(
                        key: model.carMakeKey,
                        child: Expanded(
                          child: TextFormField(
                            controller: model.tecCarMakeField,
                            validator: model.driverRegisterValidator,
                            decoration: const InputDecoration(
                              hintText: 'Car make  (eg. Suzuki)',
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: model.carModelKey,
                        child: Expanded(
                          child: TextFormField(
                            controller: model.tecCarModelField,
                            validator: model.driverRegisterValidator,
                            decoration: const InputDecoration(
                              hintText: 'Car model (eg. Ertiga)',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.025),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CarTypeBlock(
                          constraints: constraints,
                          vehicleIcon: const Icon(Icons.car_rental),
                          vehicleLabel: 'Sedan',
                          carType: CarType.sedan,
                          model: model,
                        ),
                        CarTypeBlock(
                          constraints: constraints,
                          vehicleIcon: const Icon(Icons.car_rental),
                          vehicleLabel: 'Hatchback',
                          carType: CarType.hatchback,
                          model: model,
                        ),
                        CarTypeBlock(
                          constraints: constraints,
                          vehicleIcon: const Icon(Icons.car_rental),
                          vehicleLabel: 'Truck',
                          carType: CarType.truck,
                          model: model,
                        ),
                        CarTypeBlock(
                          constraints: constraints,
                          vehicleIcon: const Icon(Icons.car_rental),
                          vehicleLabel: 'SUV',
                          carType: CarType.suv,
                          model: model,
                        ),
                        CarTypeBlock(
                          constraints: constraints,
                          vehicleIcon: const Icon(Icons.car_rental),
                          vehicleLabel: 'AUV',
                          carType: CarType.auv,
                          model: model,
                        ),
                        CarTypeBlock(
                          constraints: constraints,
                          vehicleIcon: const Icon(Icons.car_rental),
                          vehicleLabel: 'Van',
                          carType: CarType.van,
                          model: model,
                        ),
                      ],
                    ),
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
    );
  }
}

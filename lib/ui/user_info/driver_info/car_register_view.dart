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
    final controller = CarouselController();

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
            body: Form(
              key: model.carRegisterFormKey,
              child: Center(
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
                          TextFormField(
                            textCapitalization: TextCapitalization.characters,
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
                                Expanded(
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: model.tecCarMakeField,
                                    validator: model.carRegisterValidator,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03,
                                      ),
                                      hintText: 'TOYOTA',
                                      border: const OutlineInputBorder(),
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
                                Expanded(
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    controller: model.tecCarModelField,
                                    validator: model.carRegisterValidator,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03,
                                      ),
                                      hintText: 'VIOS',
                                      border: const OutlineInputBorder(),
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
                      margin:
                          EdgeInsets.only(top: constraints.maxHeight * 0.025),
                      child: Column(
                        children: [
                          const Text('Vehicle Type'),
                          const SizedBox(
                            height: 10,
                          ),
                          CarouselSlider.builder(
                            carouselController: controller,
                            itemCount: CarType.values.length,
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.5,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, _) {
                                model.setCarType(CarType.values[index]);
                              },
                            ),
                            itemBuilder: (context, index, _) {
                              return CarTypeBlock(
                                constraints: constraints,
                                model: model,
                                controller: controller,
                                carType: CarType.values[index],
                                index: index,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 69),
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      width: constraints.maxWidth * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xffdbb3d4),
                            Color(0xffd09cc7),
                          ],
                        ),
                      ),
                      child: TextButton(
                        onPressed: model.registerCar,
                        child: const Text(
                          'Register Vehicle',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

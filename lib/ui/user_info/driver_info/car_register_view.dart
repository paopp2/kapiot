import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/constants/input_formatters.dart';
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
            backgroundColor: Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.05,
                          ),
                          width: constraints.maxWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.025,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'License Plate',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff333333),
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color(0xffF8F9FD),
                                    border: Border.all(
                                      color: const Color(0xffF2F3F8),
                                      width: 2,
                                    ),
                                  ),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    inputFormatters: [UpperCaseTextFormatter()],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      color: const Color(0xff333333),
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03,
                                      ),
                                      hintText: 'ABC 123',
                                      border: InputBorder.none,
                                    ),
                                    controller: model.tecLicensePlateField,
                                    validator: model.carRegisterValidator,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
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
                                    Text(
                                      'Make',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff333333),
                                        fontSize: 14,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: const Color(0xffF8F9FD),
                                          border: Border.all(
                                            color: const Color(0xffF2F3F8),
                                            width: 2,
                                          ),
                                        ),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          inputFormatters: [
                                            UpperCaseTextFormatter(),
                                          ],
                                          controller: model.tecCarMakeField,
                                          validator: model.carRegisterValidator,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 17,
                                            color: const Color(0xff333333),
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal:
                                                  constraints.maxWidth * 0.03,
                                            ),
                                            hintText: 'TOYOTA',
                                            border: InputBorder.none,
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
                                    Text(
                                      'Model',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xff333333),
                                        fontSize: 14,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: const Color(0xffF8F9FD),
                                          border: Border.all(
                                            color: const Color(0xffF2F3F8),
                                            width: 2,
                                          ),
                                        ),
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          inputFormatters: [
                                            UpperCaseTextFormatter(),
                                          ],
                                          controller: model.tecCarModelField,
                                          validator: model.carRegisterValidator,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 17,
                                            color: const Color(0xff333333),
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal:
                                                  constraints.maxWidth * 0.03,
                                            ),
                                            hintText: 'VIOS',
                                            border: InputBorder.none,
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
                          margin: EdgeInsets.only(
                              top: constraints.maxHeight * 0.025),
                          child: Column(
                            children: [
                              Text(
                                'Vehicle Type',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff333333),
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                ),
                              ),
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
                      ],
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                      child: ElevatedButton(
                        onPressed: model.registerCar,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF5F45A4),
                          elevation: 0,
                          fixedSize: Size(constraints.maxWidth * 0.725, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Register Vehicle',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 1.5,
                          ),
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

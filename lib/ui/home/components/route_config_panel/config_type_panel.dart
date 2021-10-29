import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:kapiot/model/car/car.dart';
import 'package:kapiot/ui/shared/location_input_container.dart';

class ConfigTypePanel extends HookConsumerWidget {
  const ConfigTypePanel({
    Key? key,
    required this.pageController,
    required this.isRider,
    required this.model,
    required this.constraints,
  }) : super(key: key);

  final PageController pageController;
  final bool isRider;
  final HomeViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserInfo = ref.watch(currentUserInfoProvider).data?.value;
    final isRegisteredDriver = currentUserInfo?.isRegisteredDriver;
    final chosenCar = ref.watch(chosenCarProvider).state;
    final riderCount = ref.watch(riderCountProvider).state;
    final startAddress = ref.watch(startLocProvider).state?.address;
    final endAddress = ref.watch(endLocProvider).state?.address;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: constraints.maxHeight * 0.02,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isRider ? 'Ride' : 'Drive',
                      style: GoogleFonts.poppins(
                        fontSize: 34,
                        letterSpacing: 2,
                        color: const Color(0xff333333),
                      ),
                    ),
                    Visibility(
                      visible: isRegisteredDriver ?? false,
                      child: IconButton(
                        icon: Icon(
                          isRider
                              ? Icons.arrow_back_ios
                              : Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          pageController.animateToPage(
                            isRider ? 1 : 0,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.linearToEaseOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffF2F3F8),
                    width: 2,
                  ),
                  color: const Color(0xffF8F9FD),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05),
                child: Column(
                  children: [
                    LocationInputContainer(
                      constraints: constraints,
                      text: startAddress,
                      hint: 'Start Location',
                      leadingIcon: CupertinoIcons.smallcircle_fill_circle_fill,
                      onPressed: () => model.openRoutePlacePicker(
                        isForStartLoc: true,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 0.05,
                    ),
                    LocationInputContainer(
                      constraints: constraints,
                      text: endAddress,
                      hint: 'End Location',
                      leadingIcon: CupertinoIcons.location,
                      onPressed: () => model.openRoutePlacePicker(
                        isForStartLoc: false,
                      ),
                    ),
                  ],
                ),
              ),
              isRider
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 60,
                          width: constraints.maxWidth * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xffF2F3F8),
                              width: 2,
                            ),
                            color: const Color(0xffF8F9FD),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 50,
                                child: Icon(
                                  FontAwesomeIcons.users,
                                  color: Color(0xFF5F45A4),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: model.decRiderCount,
                                      icon: const Icon(
                                        CupertinoIcons.minus_circled,
                                        color: Color(0xFF5F45A4),
                                        size: 35,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                      child: Center(
                                        child: Text(
                                          "$riderCount",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff333333),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: model.incRiderCount,
                                      icon: const Icon(
                                        CupertinoIcons.add_circled,
                                        color: Color(0xFF5F45A4),
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        (chosenCar != null)
                            ? Container(
                                height: 60,
                                width: constraints.maxWidth * 0.375,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: const Color(0xffF2F3F8),
                                    width: 2,
                                  ),
                                  color: const Color(0xffF8F9FD),
                                  // color: Color(0xffE4E1FE),
                                ),
                                child: Column(
                                  children: [
                                    Image(
                                      image: chosenCar.type.image,
                                      height: 40,
                                    ),
                                    Text(
                                      chosenCar.licensePlateNum.toUpperCase(),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff333333),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => model.getDateTime(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Color(0xFF5F45A4),
                        width: 2,
                      ),
                      elevation: 0,
                      fixedSize: Size(constraints.maxWidth * 0.1, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Icon(
                      CupertinoIcons.calendar,
                      color: Color(0xFF5F45A4),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => model.pushRouteConfig(isRider),
                    // TODO: Remove method below on production
                    onLongPress: () => model.pushReadyMadeConfig(isRider),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF5F45A4),
                      elevation: 0,
                      fixedSize: Size(constraints.maxWidth * 0.725, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      isRider ? "Book Now" : "Start Trip",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 17,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

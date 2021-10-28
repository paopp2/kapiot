import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
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
    final dateTime = ref.watch(dateTimeProvider).state;
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
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.01),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        (chosenCar != null)
                            ? Column(
                                children: [
                                  Image(
                                    image: chosenCar.type.image,
                                    height: 40,
                                  ),
                                  Text(chosenCar.licensePlateNum),
                                ],
                              )
                            : const SizedBox(),
                        const Icon(
                          CupertinoIcons.person_3,
                          size: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RawMaterialButton(
                              fillColor: Colors.blue,
                              elevation: 0,
                              shape: const CircleBorder(),
                              onPressed: model.decRiderCount,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            Text("$riderCount"),
                            RawMaterialButton(
                              fillColor: Colors.blue,
                              elevation: 0,
                              shape: const CircleBorder(),
                              onPressed: model.incRiderCount,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
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
                        color: Color(0xFF8B80FD),
                        // const Color(0xFF6F6AFD),
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
                      color: Color(0xFF716BFD),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => model.pushRouteConfig(isRider),
                    // TODO: Remove method below on production
                    onLongPress: () => model.pushReadyMadeConfig(isRider),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF716bfd),
                      side: const BorderSide(
                        color: Color(0xFF8B80FD),
                        width: 2,
                      ),
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
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       // Visibility(
          //       //   visible: isRegisteredDriver ?? false,
          //       //   child: IconButton(
          //       //     icon: Icon(
          //       //       isRider ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
          //       //     ),
          //       //     onPressed: () {
          //       //       pageController.animateToPage(
          //       //         isRider ? 1 : 0,
          //       //         duration: const Duration(milliseconds: 1000),
          //       //         curve: Curves.linearToEaseOut,
          //       //       );
          //       //     },
          //       //   ),
          //       // ),
          //       // Container(
          //       //   margin: EdgeInsets.symmetric(
          //       //     vertical: constraints.maxHeight * 0.02,
          //       //   ),
          //       // ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           ElevatedButton(
          //             onPressed: () => model.getDateTime(context),
          //             style: TextButton.styleFrom(
          //               backgroundColor: Colors.white,
          //               side: const BorderSide(
          //                 color: Color(0xFF8B80FD),
          //                 // const Color(0xFF6F6AFD),
          //                 width: 2,
          //               ),
          //               elevation: 0,
          //               fixedSize: Size(constraints.maxWidth * 0.1, 50),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //             ),
          //             child: const Icon(
          //               CupertinoIcons.calendar,
          //               color: Color(0xFF716BFD),
          //             ),
          //           ),
          //           ElevatedButton(
          //             onPressed: () => model.pushRouteConfig(isRider),
          //             // TODO: Remove method below on production
          //             onLongPress: () => model.pushReadyMadeConfig(isRider),
          //             style: TextButton.styleFrom(
          //               backgroundColor: const Color(0xFF716bfd),
          //               side: const BorderSide(
          //                 color: Color(0xFF8B80FD),
          //                 width: 2,
          //               ),
          //               elevation: 0,
          //               fixedSize: Size(constraints.maxWidth * 0.725, 50),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //             ),
          //             child: Text(
          //               isRider ? "Book Now" : "Start Trip",
          //               style: GoogleFonts.montserrat(
          //                 color: Colors.white,
          //                 fontSize: 17,
          //                 letterSpacing: 1.5,
          //               ),
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

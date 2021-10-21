import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.02,
                ),
                margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.015),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        isRider ? 'Ride' : 'Drive',
                        style:
                            GoogleFonts.rubik(fontSize: 34, letterSpacing: 2),
                      ),
                    ),
                    Visibility(
                      visible: !isRider,
                      child: GestureDetector(
                        onTap: model.openUserInfoDrawer,
                        child: Column(
                          children: [
                            const Image(
                              image: AssetImage(
                                'assets/images/car_body_types/coupe.png',
                              ),
                              height: 40,
                            ),
                            Text(chosenCar?.licensePlateNum ?? ''),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0XFFE7DFE0),
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
                      leadingIcon: CupertinoIcons.smallcircle_circle,
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
              TextButton(
                child: Text(Jiffy(dateTime).yMMMMEEEEdjm),
                onPressed: () => model.getDateTime(context),
              ),
              isRider
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                    ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isRider ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  ),
                  onPressed: () {
                    pageController.animateToPage(
                      isRider ? 1 : 0,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.linearToEaseOut,
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.02,
                  ),
                  // child: const Divider(
                  //   color: Colors.grey,
                  //   thickness: 1,
                  //   height: 0.05,
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: constraints.maxWidth * 0.05,
                    bottom: constraints.maxHeight * 0.01,
                  ),
                  child: ElevatedButton(
                    child: Text(isRider ? "Book Now" : "Start Trip"),
                    onPressed: () => model.pushRouteConfig(isRider),
                    // TODO: Remove method below on production
                    onLongPress: () => model.pushReadyMadeConfig(isRider),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

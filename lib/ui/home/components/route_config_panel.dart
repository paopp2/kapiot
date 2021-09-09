import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:jiffy/jiffy.dart';
import 'package:kapiot/logic/shared/map_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class RouteConfigPanel extends HookConsumerWidget {
  RouteConfigPanel({
    Key? key,
    required this.constraints,
    required this.model,
  }) : super(key: key);

  final BoxConstraints constraints;
  final HomeViewModel model;
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ConfigTypePanel(
            pageController: pageController,
            isRider: true,
            model: model,
            constraints: constraints,
          ),
          ConfigTypePanel(
            pageController: pageController,
            isRider: false,
            model: model,
            constraints: constraints,
          )
        ],
      ),
    );
  }
}

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
    final riderCount = ref.watch(riderCountProvider).state;
    final dateTime = ref.watch(dateTimeProvider).state;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.01,
                ),
                padding: EdgeInsets.only(left: constraints.maxWidth * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    isRider ? 'Rider' : 'Driver',
                    style: GoogleFonts.rubik(fontSize: 34, letterSpacing: 2),
                  ),
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
                        constraints: constraints, isStart: true),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 0.05,
                    ),
                    LocationInputContainer(
                      constraints: constraints,
                      isStart: false,
                    ),
                  ],
                ),
              ),
              TextButton(
                child: Text(Jiffy(dateTime).yMMMMEEEEdjm),
                onPressed: () => model.getDateTime(context),
              ),
              !isRider
                  ? Padding(
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
                    )
                  : const SizedBox(),
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
                  child: const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 0.05,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: constraints.maxWidth * 0.05,
                    bottom: constraints.maxHeight * 0.01,
                  ),
                  child: ElevatedButton(
                    child: Text(isRider ? "Book Now" : "Start Trip"),
                    onPressed: () => model.pushRouteConfig(isRider),
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

class LocationInputContainer extends HookConsumerWidget {
  const LocationInputContainer({
    Key? key,
    required this.constraints,
    required this.isStart,
  }) : super(key: key);

  final BoxConstraints constraints;
  final bool isStart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAddress = ref.watch(startLocProvider).state?.address;
    final endAddress = ref.watch(endLocProvider).state?.address;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.025,
        vertical: constraints.maxHeight * 0.015,
      ),
      child: GestureDetector(
        onTap: () {
          print('row tapped');
        },
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: constraints.maxWidth * 0.03),
              child: Icon(
                isStart
                    ? CupertinoIcons.smallcircle_circle
                    : CupertinoIcons.location,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  isStart
                      ? (startAddress ?? 'Start Location')
                      : (endAddress ?? 'End Location'),
                  style: TextStyle(
                    fontSize: 17,
                    color: isStart
                        ? ((startAddress != null) ? Colors.black : Colors.grey)
                        : ((endAddress != null) ? Colors.black : Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

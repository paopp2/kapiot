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
    final isRider = ref.watch(isRiderProvider).state;
    final riderCount = ref.watch(riderCountProvider).state;
    final dateTime = ref.watch(dateTimeProvider).state;
    final startAddress = ref.watch(startLocProvider).state?.address ?? '';
    final endAddress = ref.watch(endLocProvider).state?.address ?? '';

    return Expanded(
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          RuntimeType(
              pageController: pageController,
              isRider: isRider,
              model: model,
              constraints: constraints,
              startAddress: startAddress,
              endAddress: endAddress,
              dateTime: dateTime,
              riderCount: riderCount),
          RuntimeType(
              pageController: pageController,
              isRider: !isRider,
              model: model,
              constraints: constraints,
              startAddress: startAddress,
              endAddress: endAddress,
              dateTime: dateTime,
              riderCount: riderCount)
        ],
      ),
    );
  }
}

class RuntimeType extends StatelessWidget {
  const RuntimeType({
    Key? key,
    required this.pageController,
    required this.isRider,
    required this.model,
    required this.constraints,
    required this.startAddress,
    required this.endAddress,
    required this.dateTime,
    required this.riderCount,
  }) : super(key: key);

  final PageController pageController;
  final bool isRider;
  final HomeViewModel model;
  final BoxConstraints constraints;
  final String startAddress;
  final String endAddress;
  final DateTime dateTime;
  final int riderCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: isRider ? Colors.grey[300] : Colors.grey[200],
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ChoiceChip(
              //       label: const Text("Driver"),
              //       selected: !isRider,
              //       onSelected: model.toggleIsRider,
              //     ),
              //     ChoiceChip(
              //       label: const Text("Rider"),
              //       selected: isRider,
              //       onSelected: model.toggleIsRider,
              //     ),
              //   ],
              // ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.01),
                padding: EdgeInsets.only(left: constraints.maxWidth * 0.02),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(isRider ? 'Rider' : 'Driver',
                      style: GoogleFonts.rubik(fontSize: 34, letterSpacing: 2)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0XFFE7DFE0)),
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05),
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.01),
                child: Column(
                  children: [
                    TextField(
                      controller: model.tecStartLoc..text = startAddress,
                      readOnly: true,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            CupertinoIcons.smallcircle_circle,
                          ),
                          hintText: "Start location",
                          border: InputBorder.none),
                      onTap: () => model.openPlacePickerView(
                        isForStartLoc: true,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                      height: 0.05,
                    ),
                    TextField(
                      controller: model.tecEndLoc..text = endAddress,
                      readOnly: true,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.location),
                        hintText: "End location",
                        border: InputBorder.none,
                      ),
                      onTap: () => model.openPlacePickerView(
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
              !isRider
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05),
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
                                child: const Icon(Icons.remove,
                                    color: Colors.white),
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
            alignment: isRider ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: constraints.maxHeight * 0.1),
              child: IconButton(
                icon: Icon(
                    isRider ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
                onPressed: () {
                  pageController.animateToPage(isRider ? 1 : 0,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.linearToEaseOut);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.03,
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
                      bottom: constraints.maxHeight * 0.01),
                  child: ElevatedButton(
                    child: Text(isRider ? "Book Now" : "Start Trip"),
                    onPressed: model.pushRouteConfig,
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

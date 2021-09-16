import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:marquee/marquee.dart';

import 'components/requesting_riders_panel.dart';
import 'components/stop_point_panel.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    final nextStop = ref.watch(nextStopProvider).state;

    double height;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    // print('flag is $flag');
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // (nextStop == null)
          //     ? height = constraints.maxHeight * 0.4
          //     : height = constraints.maxHeight * 0.15;
          return Scaffold(
            body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.8,
                          // color: Colors.amber,
                          // child: const Center(
                          //   child: Text('Map Here'),
                          // ),
                          child: const GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                10.367889719519498,
                                123.91382842505321,
                              ),
                              zoom: 20,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7)
                              ],
                            ),
                            margin: EdgeInsets.only(
                                top: constraints.maxHeight * 0.025),
                            padding:
                                EdgeInsets.all(constraints.maxWidth * 0.025),
                            height: constraints.maxHeight * 0.175,
                            width: constraints.maxWidth * 0.8,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * 0.75,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            right:
                                                constraints.maxWidth * 0.025),
                                        child: const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.amber,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 60,
                                          child: Column(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  'Name',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 25,
                                                child: Marquee(
                                                  text:
                                                      'Sunlight Drive, Sunny Hills Subdivision, Talamban, Cebu City',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                  blankSpace: 90,
                                                  pauseAfterRound:
                                                      const Duration(
                                                          seconds: 2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "ACTION: ",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        print('next stop point');
                                      },
                                      child: const Text("Done"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.2,
                      width: constraints.maxWidth,
                      child: CarouselSlider(
                        options: CarouselOptions(enlargeCenterPage: true),
                        items: [
                          Center(
                            child: SizedBox(
                              height: constraints.maxHeight * 0.16,
                              width: constraints.maxWidth * 0.8,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 7)
                                      ],
                                    ),
                                    height: constraints.maxHeight * 0.13,
                                    width: constraints.maxWidth * 0.8,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  constraints.maxWidth * 0.02),
                                          height: constraints.maxHeight * 0.09,
                                          width: constraints.maxWidth * 0.2,
                                          color: Colors.amber,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              right:
                                                  constraints.maxWidth * 0.02),
                                          height: constraints.maxHeight * 0.09,
                                          width: constraints.maxWidth * 0.54,
                                          color: Colors.amber,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'time of booking here',
                                              ),
                                              Text(
                                                'Name of rider',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                      onTap: () {
                                        print('rider has been accepted');
                                      },
                                      child: Container(
                                        color: Colors.grey,
                                        height: constraints.maxHeight * 0.045,
                                        width: constraints.maxWidth * 0.4,
                                        child: Center(child: Text('Accept')),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )

                // Column(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     (nextStop == null)
                //         ? const SizedBox()
                //         : StopPointPanel(
                //             model: model,
                //             constraints: constraints,
                //             nextStop: nextStop,
                //           ),
                //     Container(
                //       height: constraints.maxHeight * 0.6,
                //       width: constraints.maxWidth,
                //       color: Colors.amber,
                //       child: const Center(child: Text('Map here')),
                //     ),
                //     RequestingRidersPanel(
                //       model: model,
                //       constraints: constraints,
                //       height: height,
                //     ),
                //   ],
                // ),
                ),
          );
        },
      ),
    );
  }
}

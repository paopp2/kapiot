import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:marquee/marquee.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class StopPointPanel extends HookConsumerWidget {
  const StopPointPanel({
    Key? key,
    required this.model,
    required this.constraints,
  }) : super(key: key);

  final RiderManagerViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStop = ref.watch(currentStopProvider).state;
    final rider = currentStop?.rider;

    return Expanded(
        child: (currentStop == null)
            ? const Center(
                child: Text("No stop points"),
              )
            : Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(rider?.photoUrl ?? uscLogo),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.6,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    rider?.displayName ?? 'No name',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text("ACTION: " +
                                      ((currentStop.isPickUp)
                                          ? "Pick up"
                                          : "Drop off")),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Marquee(
                          text: (currentStop.stopLocation.address ?? ""),
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                          blankSpace: 90,
                          pauseAfterRound: Duration(seconds: 2),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: model.nextStop,
                          child: const Text("Done"),
                        )
                      ],
                    ),
                  ],
                ),
              )
        // Container(
        //     color: Colors.white,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Text("NEXT STOP POINT"),
        //         CircleAvatar(
        //           backgroundImage: NetworkImage(rider?.photoUrl ?? uscLogo),
        //         ),
        //         Text("RIDER: " + (rider?.displayName ?? 'No name')),
        //         Text("ACTION: " +
        //             ((currentStop.isPickUp) ? "Pick up" : "Drop off")),
        //         Text("WHERE: " + (currentStop.stopLocation.address ?? "")),
        //         const Text("DISTANCE: 69m"),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             ElevatedButton(
        //               onPressed: () {},
        //               child: const Text("Cancel"),
        //             ),
        //             ElevatedButton(
        //               onPressed: model.nextStop,
        //               child: const Text("Done"),
        //             )
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';
import 'package:marquee/marquee.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class StopPointPanel extends HookConsumerWidget {
  const StopPointPanel({
    Key? key,
    required this.model,
    required this.constraints,
    required this.nextStop,
  }) : super(key: key);

  final RiderManagerViewModel model;
  final BoxConstraints constraints;
  final StopPoint nextStop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rider = nextStop.rider;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: constraints.maxWidth * 0.1),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(rider.photoUrl ?? uscLogo),
                    ),
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
                            rider.displayName ?? 'No name',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "ACTION: " +
                                ((nextStop.isPickUp) ? "Pick up" : "Drop off"),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.06,
              child: Marquee(
                text: (nextStop.stopLocation.address ?? ""),
                style: const TextStyle(fontSize: 17, color: Colors.grey),
                blankSpace: 90,
                pauseAfterRound: const Duration(seconds: 2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: model.updateNextStop,
                  child: const Text("Done"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

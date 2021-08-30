import 'package:flutter/material.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/model/stop_point/stop_point.dart';
import 'package:marquee/marquee.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class StopPointPanel extends StatelessWidget {
  const StopPointPanel({
    Key? key,
    required this.model,
    required this.constraints,
    required this.currentStop,
  }) : super(key: key);

  final RiderManagerViewModel model;
  final BoxConstraints constraints;
  final StopPoint currentStop;

  @override
  Widget build(BuildContext context) {
    final rider = currentStop.rider;

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.02),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Spacer(),
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(rider.photoUrl ?? uscLogo),
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
              child: Marquee(
                text: (currentStop.stopLocation.address ?? ""),
                style: const TextStyle(fontSize: 17, color: Colors.grey),
                blankSpace: 90,
                pauseAfterRound: const Duration(seconds: 2),
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
      ),
    );
  }
}

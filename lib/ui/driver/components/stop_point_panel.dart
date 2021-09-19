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
    required this.nextStop,
  }) : super(key: key);

  final RiderManagerViewModel model;
  final BoxConstraints constraints;
  final StopPoint nextStop;

  @override
  Widget build(BuildContext context) {
    final rider = nextStop.rider;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xafffffff),
              Color(0x00ffffff),
            ],
          ),
          borderRadius: BorderRadiusDirectional.circular(5),
        ),
        padding: EdgeInsets.all(constraints.maxWidth * 0.025),
        height: 130,
        width: constraints.maxWidth * 0.8,
        child: Column(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.75,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      right: constraints.maxWidth * 0.025,
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(rider.photoUrl ?? uscLogo),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              rider.displayName ?? 'No name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Marquee(
                              text: nextStop.stopLocation.address ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                              blankSpace: 90,
                              pauseAfterRound: const Duration(seconds: 2),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  (nextStop.isPickUp) ? "Pick-up" : "Drop-off",
                  style: const TextStyle(fontSize: 14),
                ),
                ElevatedButton(
                  onPressed: model.updateNextStop,
                  child: const Text("Next stop"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

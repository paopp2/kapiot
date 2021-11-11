import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final rider = nextStop.riderConfig.user;
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
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
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                              image: NetworkImage(rider.photoUrl ?? uscLogo),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
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
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  color: const Color(0xff333333),
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                              child: Marquee(
                                text: nextStop.stopLocation.address ?? '',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xff333333),
                                  fontSize: 13,
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
                    style: GoogleFonts.montserrat(
                      color: const Color(0xff333333),
                      fontSize: 13,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: model.updateNextStop,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF5F45A4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      "Next stop",
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
        ),
      ),
    );
  }
}

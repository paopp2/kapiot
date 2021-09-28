import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_state.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/ui/post_trip_summary/info_block_widget.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class PostTripSummaryView extends HookConsumerWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    final model = ref.watch(postTripSummaryViewModel);
    final isDriver = ref.watch(isDriverProvider);
    final transaction = ref.watch(transactionProvider).state;
    final driver = transaction.driver!.user;
    final startAddress = transaction.startLocation?.address ?? 'No start addr';
    final endAddress = transaction.endLocation?.address ?? 'No end addr';
    final riders = transaction.riders!.map((rc) => rc.user).toList();
    final points = ref.watch(pointsProvider);
    final distanceInKm = ref.watch(distanceInKmProvider);
    final timeInMins = ref.watch(timeInMinsProvider);
    final totalPoints = ref.watch(totalPointsProvider);
    const idNumber = '18105024';
    const plateNumber = 'FAG 169';

    useEffect(() {
      // Throw confetti after 3 seconds
      Future.delayed(const Duration(seconds: 3)).then((value) {
        confettiController.play();
      });
      model.initState();
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Entry(
                        yOffset: (constraints.maxHeight / 2) -
                            (constraints.maxHeight * 0.35 / 2),
                        delay: const Duration(milliseconds: 1500),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInToLinear,
                        child: Container(
                          height: constraints.maxHeight * 0.35,
                          width: constraints.maxWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.05,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'You have arrived at your destination.',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: const Color(0xff333333),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              AnimatedFlipCounter(
                                value: points,
                                duration: const Duration(milliseconds: 3500),
                                curve: Curves.linearToEaseOut,
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 81,
                                  color: const Color(0xff333333),
                                ),
                              ),
                              Text(
                                'Points earned',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: const Color(0xff666666),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      ),
                      Entry(
                        yOffset: 1000,
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.easeInToLinear,
                        child: Container(
                          height: constraints.maxHeight * 0.65,
                          width: constraints.maxWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.05,
                            vertical: constraints.maxHeight * 0.025,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff666666),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isDriver
                                  ? Container(
                                      padding: const EdgeInsets.only(top: 25),
                                      width: constraints.maxWidth,
                                      child: Column(
                                        children: [
                                          Text(
                                            driver.displayName ?? 'No Name',
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Text(
                                            idNumber,
                                            style: GoogleFonts.poppins(
                                              height: 1,
                                              fontSize: 14,
                                              color: const Color(0xff666666),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Material(
                                          elevation: 2,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          child: Container(
                                            height: 70,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    driver.photoUrl!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              left:
                                                  constraints.maxWidth * 0.025,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      driver.displayName ??
                                                          'No Name',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 24,
                                                        color: const Color(
                                                            0xff333333),
                                                      ),
                                                    ),
                                                    Text(
                                                      plateNumber,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xff666666),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  idNumber,
                                                  style: GoogleFonts.poppins(
                                                    height: 1,
                                                    fontSize: 14,
                                                    color:
                                                        const Color(0xff666666),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      startAddress,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: const Color(0xff574754),
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      endAddress,
                                      style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        color: const Color(0xff574754),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoBlockWidget(
                                    constraints: constraints,
                                    number: distanceInKm,
                                    type: 'km',
                                  ),
                                  InfoBlockWidget(
                                    constraints: constraints,
                                    number: timeInMins,
                                    type: 'minutes',
                                  ),
                                  InfoBlockWidget(
                                    constraints: constraints,
                                    number: totalPoints,
                                    type: 'total points',
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: isDriver,
                                      child: Text(
                                        'Passengers',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: const Color(0xff574754),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.85,
                                      height: constraints.maxHeight * 0.1,
                                      child: Center(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: riders.length,
                                          itemBuilder: (context, index) {
                                            final rider = riders[index];
                                            return Align(
                                              widthFactor: 0.8,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 27,
                                                  backgroundImage: NetworkImage(
                                                    rider.photoUrl ?? uscLogo,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Entry(
                                xOffset: -1000,
                                delay: const Duration(milliseconds: 1000),
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeInToLinear,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'home',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: const Color(
                                          0xff666666,
                                        ),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                        constraints.maxWidth * 0.25,
                                        constraints.maxHeight * 0.06,
                                      ),
                                      side: const BorderSide(
                                        color: Color(0xffdbb3d4),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      primary: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: isDriver,
                    child: Positioned(
                      top: (constraints.maxHeight * 0.35) - 40,
                      left: (constraints.maxWidth / 2) - 40,
                      child: Entry.scale(
                        delay: const Duration(milliseconds: 2000),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInToLinear,
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(40),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            child: CircleAvatar(
                              radius: 37,
                              backgroundImage: NetworkImage(
                                driver.photoUrl ?? uscLogo,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.175,
                    left: constraints.maxWidth / 2,
                    child: ConfettiWidget(
                      confettiController: confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      numberOfParticles: 20,
                      colors: const [
                        Color(0xffdbb3d4),
                        Color(0xffe5d392),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

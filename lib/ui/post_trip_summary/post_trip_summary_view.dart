import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:kapiot/ui/post_trip_summary/info_block_widget.dart';

class PostTripSummaryView extends StatelessWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDriver = true; // set panel type here

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Center(
              child: PostTripPanel(
                constraints: constraints,
                isDriver: isDriver,
              ),
            ),
          );
        },
      ),
    );
  }
}

class PostTripPanel extends StatefulWidget {
  const PostTripPanel({
    Key? key,
    required this.constraints,
    required this.isDriver,
  }) : super(key: key);

  final BoxConstraints constraints;
  final bool isDriver;

  @override
  State<PostTripPanel> createState() => _PostTripPanelState();
}

class _PostTripPanelState extends State<PostTripPanel> {
  late ConfettiController controller;

  double points = 0;
  double numKm = 0;
  double numMin = 0;
  double numTotal = 0;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: const Duration(seconds: 2));

    Future.delayed(const Duration(milliseconds: 10)).then((value) {
      setState(() {
        points = 33;
      });
    });

    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      setState(() {
        numKm = 5.8;
        numMin = 17;
        numTotal = 47;
      });
    });

    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      setState(() {
        controller.play();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Entry(
              yOffset: (widget.constraints.maxHeight / 2) -
                  (widget.constraints.maxHeight * 0.35 / 2),
              delay: const Duration(milliseconds: 1500),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInToLinear,
              child: Container(
                height: widget.constraints.maxHeight * 0.35,
                width: widget.constraints.maxWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.constraints.maxWidth * 0.05,
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
                height: widget.constraints.maxHeight * 0.65,
                width: widget.constraints.maxWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.constraints.maxWidth * 0.05,
                  vertical: widget.constraints.maxHeight * 0.025,
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
                    widget.isDriver
                        ? Container(
                            padding: const EdgeInsets.only(top: 25),
                            width: widget.constraints.maxWidth,
                            child: Column(
                              children: [
                                Text(
                                  'Christian G.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    color: const Color(0xff333333),
                                  ),
                                ),
                                Text(
                                  '18105024',
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
                                borderRadius: BorderRadius.circular(9),
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: widget.constraints.maxWidth * 0.025,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Christian G.',
                                            style: GoogleFonts.poppins(
                                              fontSize: 24,
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                          Text(
                                            'FAG 169',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color(0xff666666),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '18105024',
                                        style: GoogleFonts.poppins(
                                          height: 1,
                                          fontSize: 14,
                                          color: const Color(0xff666666),
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
                            'Eskina Japan',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color(0xff574754),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Eskina Singapore',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoBlockWidget(
                          constraints: widget.constraints,
                          number: numKm,
                          type: 'km',
                        ),
                        InfoBlockWidget(
                          constraints: widget.constraints,
                          number: numMin,
                          type: 'minutes',
                        ),
                        InfoBlockWidget(
                          constraints: widget.constraints,
                          number: numTotal,
                          type: 'total points',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: widget.constraints.maxWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: widget.isDriver,
                            child: Text(
                              'Passengers',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: const Color(0xff574754),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: widget.constraints.maxWidth * 0.85,
                            height: widget.constraints.maxHeight * 0.1,
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: const [
                                  Align(
                                    widthFactor: 0.8,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    widthFactor: 0.8,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    widthFactor: 0.8,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ],
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
                              widget.constraints.maxWidth * 0.25,
                              widget.constraints.maxHeight * 0.06,
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
          visible: widget.isDriver,
          child: Positioned(
            top: (widget.constraints.maxHeight * 0.35) - 40,
            left: (widget.constraints.maxWidth / 2) - 40,
            child: Entry.scale(
              delay: const Duration(milliseconds: 2000),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInToLinear,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(40),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 37,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: widget.constraints.maxHeight * 0.175,
          left: widget.constraints.maxWidth / 2,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 20,
            colors: const [
              Color(0xffdbb3d4),
              Color(0xffe5d392),
            ],
          ),
        ),
      ],
    );
  }
}

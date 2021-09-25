import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';

class PostTripSummaryView extends StatefulWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  _PostTripSummaryViewState createState() => _PostTripSummaryViewState();
}

class _PostTripSummaryViewState extends State<PostTripSummaryView> {
  late ConfettiController controller;

  @override
  void initState() {
    super.initState();
    controller = ConfettiController(duration: Duration(seconds: 3));
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Center(
              child: Stack(
                children: [
                  Container(
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
                        Text(
                          '69',
                          style: GoogleFonts.poppins(
                            fontSize: 81,
                            color: const Color(0xff333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Points earned',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color(
                              0xff666666,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: constraints.maxHeight * 0.65,
                      color: Colors.transparent,
                      child: Container(
                        width: constraints.maxWidth,
                        padding: EdgeInsets.only(
                          top: 50,
                          left: constraints.maxWidth * 0.05,
                          right: constraints.maxWidth * 0.05,
                        ),
                        decoration: BoxDecoration(
                          // color: Color(0xffdbb3d4),
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
                          children: [
                            Container(
                              width: constraints.maxWidth,
                              child: Column(
                                children: [
                                  Text(
                                    'Christian G.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      color: Color(0xff333333),
                                    ),
                                  ),
                                  Text(
                                    '18105024',
                                    style: GoogleFonts.poppins(
                                      height: 1,
                                      fontSize: 14,
                                      color: Color(0xff666666),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: constraints.maxHeight * 0.025,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Eskina Japan',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Color(0xff574754),
                                    ),
                                  ),
                                  Text(
                                    'Eskina Singapore',
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      color: Color(0xff574754),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * 0.025,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoBlockWidget(
                                      constraints: constraints,
                                      value: '6.9',
                                      type: 'km'),
                                  InfoBlockWidget(
                                      constraints: constraints,
                                      value: '6',
                                      type: 'minutes'),
                                  InfoBlockWidget(
                                      constraints: constraints,
                                      value: '96',
                                      type: 'total points'),
                                ],
                              ),
                            ),
                            Container(
                              // color: Colors.amber,
                              width: constraints.maxWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Passengers',
                                  //   style: GoogleFonts.poppins(
                                  //     fontSize: 16,
                                  //     color: Color(0xff574754),
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: constraints.maxHeight * 0.1,
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
                                                  backgroundColor:
                                                      Colors.purple,
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
                                                  backgroundColor:
                                                      Colors.purple,
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
                                                  backgroundColor:
                                                      Colors.purple,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'You and n others',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: const Color(
                                            0xff666666,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Align(
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
                                    fixedSize: const Size(110, 50),
                                    side: const BorderSide(
                                        color: Color(0xffdbb3d4)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    primary: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: (constraints.maxHeight * 0.35) - 40,
                    left: (constraints.maxWidth / 2) - 40,
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
                  Positioned(
                    top: constraints.maxHeight * 0.175,
                    left: constraints.maxWidth / 2,
                    child: ConfettiWidget(
                      confettiController: controller,
                      blastDirectionality: BlastDirectionality.explosive,
                      numberOfParticles: 20,
                      colors: [Color(0xffdbb3d4), Color(0xffe5d392)],
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

// class PostTripSummaryView extends StatefulWidget {

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return Scaffold(
//             // backgroundColor: Color(0xffdbb3d4),
//             body: Center(
//               child: Stack(
//                 children: [
//                   ConfettiWidget(confettiController: controller),
//                   Container(
//                     height: constraints.maxHeight * 0.35,
//                     width: constraints.maxWidth,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: constraints.maxWidth * 0.05,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'You have arrived at your destination.',
//                           style: GoogleFonts.poppins(
//                             fontSize: 18,
//                             color: const Color(0xff333333),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
//                           '69',
//                           style: GoogleFonts.poppins(
//                             fontSize: 81,
//                             color: const Color(0xff333333),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         Text(
//                           'Points earned',
//                           style: GoogleFonts.montserrat(
//                             fontSize: 14,
//                             color: const Color(
//                               0xff666666,
//                             ),
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         )
//                       ],
//                     ),
//                   ),

//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: constraints.maxHeight * 0.65,
//                       color: Colors.transparent,
//                       child: Container(
//                         width: constraints.maxWidth,
//                         padding: EdgeInsets.only(
//                           top: 50,
//                           left: constraints.maxWidth * 0.05,
//                           right: constraints.maxWidth * 0.05,
//                         ),
//                         decoration: BoxDecoration(
//                           // color: Color(0xffdbb3d4),
//                           border: Border.all(
//                             color: const Color(0xff666666),
//                           ),
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(24),
//                             topRight: Radius.circular(24),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               width: constraints.maxWidth,
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Christian G.',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 24,
//                                       color: Color(0xff333333),
//                                     ),
//                                   ),
//                                   Text(
//                                     '18105024',
//                                     style: GoogleFonts.poppins(
//                                       height: 1,
//                                       fontSize: 14,
//                                       color: Color(0xff666666),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(
//                                 top: constraints.maxHeight * 0.025,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Eskina Japan',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       color: Color(0xff574754),
//                                     ),
//                                   ),
//                                   Text(
//                                     'Eskina Singapore',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 28,
//                                       color: Color(0xff574754),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.symmetric(
//                                 vertical: constraints.maxHeight * 0.025,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   InfoBlockWidget(
//                                       constraints: constraints,
//                                       value: '6.9',
//                                       type: 'km'),
//                                   InfoBlockWidget(
//                                       constraints: constraints,
//                                       value: '6',
//                                       type: 'minutes'),
//                                   InfoBlockWidget(
//                                       constraints: constraints,
//                                       value: '96',
//                                       type: 'total points'),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               // color: Colors.amber,
//                               width: constraints.maxWidth,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Passengers',
//                                     style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       color: Color(0xff574754),
//                                     ),
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         height: constraints.maxHeight * 0.1,
//                                         child: ListView(
//                                           shrinkWrap: true,
//                                           scrollDirection: Axis.horizontal,
//                                           children: const [
//                                             Align(
//                                               widthFactor: 0.8,
//                                               child: CircleAvatar(
//                                                 radius: 30,
//                                                 backgroundColor: Colors.white,
//                                                 child: CircleAvatar(
//                                                   radius: 27,
//                                                   backgroundColor:
//                                                       Colors.purple,
//                                                 ),
//                                               ),
//                                             ),
//                                             Align(
//                                               widthFactor: 0.8,
//                                               child: CircleAvatar(
//                                                 radius: 30,
//                                                 backgroundColor: Colors.white,
//                                                 child: CircleAvatar(
//                                                   radius: 27,
//                                                   backgroundColor:
//                                                       Colors.purple,
//                                                 ),
//                                               ),
//                                             ),
//                                             Align(
//                                               widthFactor: 0.8,
//                                               child: CircleAvatar(
//                                                 radius: 30,
//                                                 backgroundColor: Colors.white,
//                                                 child: CircleAvatar(
//                                                   radius: 27,
//                                                   backgroundColor:
//                                                       Colors.purple,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Text(
//                                         'You and n others',
//                                         style: GoogleFonts.montserrat(
//                                           fontSize: 14,
//                                           color: const Color(
//                                             0xff666666,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: (constraints.maxHeight * 0.35) - 40,
//                     left: (constraints.maxWidth / 2) - 40,
//                     child: Material(
//                       elevation: 8,
//                       borderRadius: BorderRadius.circular(40),
//                       child: const CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 40,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.purple,
//                           radius: 37,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // ElevatedButton(
//                   //   onPressed: () {},
//                   //   child: const Text('Back to HomeView'),
//                   // ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class InfoBlockWidget extends StatelessWidget {
  InfoBlockWidget({
    Key? key,
    required this.constraints,
    required this.value,
    required this.type,
  }) : super(key: key);

  BoxConstraints constraints;
  String value;
  String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: constraints.maxWidth * 0.275,
      width: constraints.maxWidth * 0.275,
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.04,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xffedd9e9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Color(0xff574754),
              // color: Color(0xff333333),
            ),
          ),
          Text(
            type,
            style: GoogleFonts.poppins(
              height: 0.5,
              fontSize: 12,
              color: Color(0xff997d94),
              // color: Color(0xff666666),
            ),
          ),
        ],
      ),
    );
  }
}

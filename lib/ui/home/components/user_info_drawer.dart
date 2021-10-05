import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

class UserInfoDrawer extends StatelessWidget {
  const UserInfoDrawer({
    Key? key,
    required this.model,
    required this.constraints,
  }) : super(key: key);

  final HomeViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    bool isRegisteredDriver = true;
    return SizedBox(
      width: constraints.maxWidth * 0.85,
      child: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: constraints.maxWidth * 0.85,
                  height: constraints.maxHeight * 0.25,
                  margin: const EdgeInsets.only(bottom: 60),
                  color: Colors.purple,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.08,
                  child: Column(
                    children: [
                      Text(
                        'Christian Benedict C. Gonzales',
                        style: GoogleFonts.poppins(
                          fontSize: constraints.maxWidth * 0.045,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '18105024 | BS CpE 3',
                        style: GoogleFonts.poppins(
                          fontSize: constraints.maxWidth * 0.03,
                          color: const Color(0xff666666),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isRegisteredDriver,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.025,
                        ),
                        height: constraints.maxWidth * 0.23,
                        width: constraints.maxWidth * 0.23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffedd9e9),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              size: constraints.maxHeight * 0.05,
                              color: const Color(0xff574754),
                            ),
                            Text(
                              '4.8',
                              style: GoogleFonts.poppins(
                                fontSize: constraints.maxHeight * 0.03,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff574754),
                              ),
                            ),
                            Text(
                              'Rating',
                              style: GoogleFonts.poppins(
                                height: 0.5,
                                fontSize: constraints.maxHeight * 0.015,
                                color: const Color(0xff997d94),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.025,
                      ),
                      height: constraints.maxWidth * 0.23,
                      width: constraints.maxWidth * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffedd9e9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hail_rounded,
                            size: constraints.maxHeight * 0.05,
                            color: const Color(0xff574754),
                          ),
                          Text(
                            '88',
                            style: GoogleFonts.poppins(
                              fontSize: constraints.maxHeight * 0.03,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff574754),
                            ),
                          ),
                          Text(
                            'Points',
                            style: GoogleFonts.poppins(
                              height: 0.5,
                              fontSize: constraints.maxHeight * 0.015,
                              color: const Color(0xff997d94),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.025,
                      ),
                      height: constraints.maxWidth * 0.23,
                      width: constraints.maxWidth * 0.23,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xffedd9e9),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            isRegisteredDriver
                                ? CupertinoIcons.group_solid
                                : CupertinoIcons.car_detailed,
                            size: constraints.maxHeight * 0.05,
                            color: const Color(0xff574754),
                          ),
                          Text(
                            '23',
                            style: GoogleFonts.poppins(
                              fontSize: constraints.maxHeight * 0.03,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff574754),
                            ),
                          ),
                          Text(
                            isRegisteredDriver ? 'Passengers' : 'Kapiot Rides',
                            style: GoogleFonts.poppins(
                              height: 0.5,
                              fontSize: constraints.maxHeight * 0.015,
                              color: const Color(0xff997d94),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: constraints.maxHeight * 0.015,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.015,
                          ),
                          child: const Text('Bookmarks'),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.025,
                              ),
                              width: constraints.maxWidth * 0.35,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Home'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.025,
                              ),
                              width: constraints.maxWidth * 0.35,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Work'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.025,
                              ),
                              width: constraints.maxWidth * 0.35,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('School'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: constraints.maxHeight * 0.015,
                  ),
                  child: isRegisteredDriver
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: constraints.maxHeight * 0.015,
                                ),
                                child: const Text('Vehicle'),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.025,
                                    ),
                                    height: constraints.maxHeight * 0.2,
                                    width: constraints.maxWidth * 0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.purple[200],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(CupertinoIcons.car),
                                        Text('FAG 164'),
                                        Text('Suzuki Ertiga'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: TextButton(
                            child: const Text('Register as Driver'),
                            onPressed: model.gotoDriverRegisterView,
                          ),
                        ),
                ),
              ],
            ),
            Positioned(
              top: (constraints.maxHeight * 0.25) - 60,
              left: ((constraints.maxWidth * 0.85) / 2) - 60,
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  // backgroundColor: Colors.amber,
                  backgroundImage: NetworkImage(
                    'https://i1.rgstatic.net/ii/profile.image/696306007810054-1543023697440_Q512/Rosana-Ferolin-2.jpg',
                  ),
                  radius: 58,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

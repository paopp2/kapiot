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
                  height: constraints.maxHeight * 0.075,
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
                        '18105024',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
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
                            color: Color(0xff574754),
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
                    Container(
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
                            color: Color(0xff574754),
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
                            CupertinoIcons.car_detailed,
                            size: constraints.maxHeight * 0.05,
                            color: Color(0xff574754),
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
                            'Kapiot Rides',
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
                )

                // cover photo
                // edit profile inlay with cover photo
                // profile photo
                // complete name
                // user id
                // infoblock widget - rating, total number of passenger hitch, total ces points
                // course and year

                // const DrawerHeader(child: Text('Kapiot (Drawer Header)')),
                // const Text('Total CES: 69'),
                // const Text('Email: email@usc.edu.ph'),
                // const Text('Course and year: BS CPE 3'),
                // const Text('Default start: Aldea Del Sol Bankal Lapu-lapu'),
                // const Text('Default end: Sunny Hills Talamban'),
                // const SizedBox(height: 20),
                // const Text('-----IF NOT DRIVER-----'),
                // TextButton(
                //   child: const Text('Register as Driver'),
                //   onPressed: model.gotoDriverRegisterView,
                // ),
                // const Text('-----IF DRIVER-----'),
                // // const Text('Rating: 4.5'),
                // const Text('License plate: ABC 069'),
                // const Text('Car make and model: Suzuki Ertiga'),
                // const Text('Car type: AUV'),
                // const Spacer(),
                // TextButton(
                //   child: const Text('Edit user info'),
                //   onPressed: model.gotoEditUserInfoView,
                // ),
              ],
            ),
            Positioned(
              top: (constraints.maxHeight * 0.25) - 60,
              left: ((constraints.maxWidth * 0.85) / 2) - 60,
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Colors.amber,
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

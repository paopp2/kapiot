import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

class UserInfoDrawer extends HookConsumerWidget {
  const UserInfoDrawer({
    Key? key,
    required this.model,
    required this.constraints,
  }) : super(key: key);

  final HomeViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider)!;
    final username = currentUser.email!.split('@').first;
    // User is a student if username can be parsed as int (ID number)
    final isStudent = (int.tryParse(username) != null);
    bool isRegisteredDriver = false;
    return SizedBox(
      width: constraints.maxWidth * 0.85,
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: constraints.maxWidth * 0.85,
              height: constraints.maxHeight * 0.25,
              color: const Color(0xffdbb3d4),
              padding: EdgeInsets.only(
                left: constraints.maxWidth * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: constraints.maxHeight * 0.015,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 53,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(currentUser.photoUrl!),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    currentUser.displayName!,
                    style: GoogleFonts.poppins(
                      fontSize: constraints.maxWidth * 0.045,
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    username,
                    style: GoogleFonts.poppins(
                      fontSize: constraints.maxWidth * 0.03,
                      color: const Color(0xff666666),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isRegisteredDriver,
                    child: const ListTile(
                      title: Text('Rating'),
                      leading: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      trailing: Text('4.8'),
                    ),
                  ),
                  const ListTile(
                    title: Text('Points'),
                    leading: Icon(Icons.score),
                    trailing: Text('58'),
                  ),
                  ExpansionTile(
                    title: const Text('My Locations'),
                    leading: const Icon(Icons.map),
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.025,
                          ),
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
                                child: Text(isStudent ? 'School' : 'Work'),
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
                                child: const Icon(Icons.add),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  isRegisteredDriver
                      ? ExpansionTile(
                          leading: Icon(Icons.drive_eta),
                          title: const Text(
                            'Owned Cars',
                          ),
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.25,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            constraints.maxWidth * 0.025,
                                      ),
                                      height: constraints.maxHeight * 0.2,
                                      width: constraints.maxWidth * 0.3,
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
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: model.gotoDriverRegisterView,
                          child: ListTile(
                            leading: Icon(Icons.drive_eta),
                            title: const Text(
                              'Register as Driver',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                ],
              ),
            )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Visibility(
            //       visible: !isRider,
            //       child: Container(
            //         margin: EdgeInsets.symmetric(
            //           horizontal: constraints.maxWidth * 0.025,
            //         ),
            //         height: constraints.maxWidth * 0.23,
            //         width: constraints.maxWidth * 0.23,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           color: const Color(0xffedd9e9),
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Icon(
            //               CupertinoIcons.star_fill,
            //               size: constraints.maxHeight * 0.05,
            //               color: Color(0xff574754),
            //             ),
            //             Text(
            //               '4.8',
            //               style: GoogleFonts.poppins(
            //                 fontSize: constraints.maxHeight * 0.03,
            //                 fontWeight: FontWeight.w600,
            //                 color: const Color(0xff574754),
            //               ),
            //             ),
            //             Text(
            //               'Rating',
            //               style: GoogleFonts.poppins(
            //                 height: 0.5,
            //                 fontSize: constraints.maxHeight * 0.015,
            //                 color: const Color(0xff997d94),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.symmetric(
            //         horizontal: constraints.maxWidth * 0.025,
            //       ),
            //       height: constraints.maxWidth * 0.23,
            //       width: constraints.maxWidth * 0.23,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         color: const Color(0xffedd9e9),
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Icon(
            //             Icons.hail_rounded,
            //             size: constraints.maxHeight * 0.05,
            //             color: Color(0xff574754),
            //           ),
            //           Text(
            //             '88',
            //             style: GoogleFonts.poppins(
            //               fontSize: constraints.maxHeight * 0.03,
            //               fontWeight: FontWeight.w600,
            //               color: const Color(0xff574754),
            //             ),
            //           ),
            //           Text(
            //             'Points',
            //             style: GoogleFonts.poppins(
            //               height: 0.5,
            //               fontSize: constraints.maxHeight * 0.015,
            //               color: const Color(0xff997d94),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.symmetric(
            //         horizontal: constraints.maxWidth * 0.025,
            //       ),
            //       height: constraints.maxWidth * 0.23,
            //       width: constraints.maxWidth * 0.23,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(12),
            //         color: const Color(0xffedd9e9),
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Icon(
            //             isRider
            //                 ? CupertinoIcons.car_detailed
            //                 : CupertinoIcons.group_solid,
            //             size: constraints.maxHeight * 0.05,
            //             color: Color(0xff574754),
            //           ),
            //           Text(
            //             '23',
            //             style: GoogleFonts.poppins(
            //               fontSize: constraints.maxHeight * 0.03,
            //               fontWeight: FontWeight.w600,
            //               color: const Color(0xff574754),
            //             ),
            //           ),
            //           Text(
            //             isRider ? 'Kapiot Rides' : 'Passengers',
            //             style: GoogleFonts.poppins(
            //               height: 0.5,
            //               fontSize: constraints.maxHeight * 0.015,
            //               color: const Color(0xff997d94),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   margin: EdgeInsets.only(
            //     top: constraints.maxHeight * 0.015,
            //   ),
            //   child: Column(
            //     children: [
            //       Align(
            //         alignment: Alignment.centerLeft,
            //         child: Container(
            //           margin: EdgeInsets.symmetric(
            //             vertical: constraints.maxHeight * 0.015,
            //           ),
            //           child: Text('Bookmarks'),
            //         ),
            //       ),
            //       SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: [
            //             Container(
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: constraints.maxWidth * 0.025,
            //               ),
            //               width: constraints.maxWidth * 0.35,
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 child: const Text('Home'),
            //                 style: ElevatedButton.styleFrom(
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(24),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: constraints.maxWidth * 0.025,
            //               ),
            //               width: constraints.maxWidth * 0.35,
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 child: const Text('Work'),
            //                 style: ElevatedButton.styleFrom(
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(24),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             Container(
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: constraints.maxWidth * 0.025,
            //               ),
            //               width: constraints.maxWidth * 0.35,
            //               child: ElevatedButton(
            //                 onPressed: () {},
            //                 child: const Text('School'),
            //                 style: ElevatedButton.styleFrom(
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(24),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(
            //     top: constraints.maxHeight * 0.015,
            //   ),
            //   child: isRider
            //       ? Center(
            //           child: TextButton(
            //             child: const Text('Register as Driver'),
            //             onPressed: model.gotoDriverRegisterView,
            //           ),
            //         )
            //       : Column(
            //           children: [
            //             Align(
            //               alignment: Alignment.centerLeft,
            //               child: Container(
            //                 margin: EdgeInsets.symmetric(
            //                   vertical: constraints.maxHeight * 0.015,
            //                 ),
            //                 child: Text('Vehicle'),
            //               ),
            //             ),
            //             SingleChildScrollView(
            //               scrollDirection: Axis.horizontal,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.symmetric(
            //                       horizontal: constraints.maxWidth * 0.025,
            //                     ),
            //                     height: constraints.maxHeight * 0.2,
            //                     width: constraints.maxWidth * 0.4,
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(12),
            //                       color: Colors.purple[200],
            //                     ),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       children: const [
            //                         Icon(CupertinoIcons.car),
            //                         Text('FAG 164'),
            //                         Text('Suzuki Ertiga'),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            // ),
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
            // const Text('Rating: 4.5'),
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
      ),
    );
  }
}

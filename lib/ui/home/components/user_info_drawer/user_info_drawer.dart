import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

import 'owned_cars_expansion_tile.dart';
import 'user_info_drawer_header.dart';

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
    final currentUserInfo = ref.watch(currentUserInfoProvider).asData?.value;
    return SizedBox(
      width: constraints.maxWidth * 0.85,
      height: constraints.maxHeight,
      child: Drawer(
        child: (currentUserInfo == null)
            ? const Center(child: Text("No user info set"))
            : Column(
                children: [
                  UserInfoDrawerHeader(constraints: constraints),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    width: constraints.maxWidth * 0.85,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: currentUserInfo.isRegisteredDriver,
                            child: ListTile(
                              title: Text(
                                'Rating',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xff414141),
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.star,
                                size: 26,
                                color: Colors.amber,
                              ),
                              minLeadingWidth: 10,
                              trailing: Text(
                                currentUserInfo.driverInfo?.averageRating ?? '',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xff414141),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Points',
                              style: GoogleFonts.montserrat(
                                color: const Color(0xff414141),
                                fontSize: 16,
                              ),
                            ),
                            leading: const Icon(
                              FontAwesomeIcons.handHoldingHeart,
                              size: 26,
                              color: Color(0xffcccccc),
                            ),
                            minLeadingWidth: 10,
                            trailing: Text(
                              '${currentUserInfo.points.toInt()}',
                              style: GoogleFonts.montserrat(
                                color: const Color(0xff414141),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: model.gotoPlaceManagerView,
                            child: ListTile(
                              title: Text(
                                'My Locations',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xff414141),
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                FontAwesomeIcons.mapMarkedAlt,
                                size: 26,
                                color: Color(0xffcccccc),
                              ),
                              minLeadingWidth: 10,
                            ),
                          ),
                          currentUserInfo.isRegisteredDriver
                              ? OwnedCarsExpansionTile(
                                  model: model,
                                  constraints: constraints,
                                  currentUserInfo: currentUserInfo,
                                )
                              : GestureDetector(
                                  onTap: model.gotoDriverRegisterView,
                                  child: ListTile(
                                    leading: Image.asset(
                                      'assets/icons/register_as_driver.png',
                                      width: 26,
                                      color: const Color(0xffcccccc),
                                    ),
                                    title: Text(
                                      'Register as Driver',
                                      style: GoogleFonts.montserrat(
                                        color: const Color(0xff414141),
                                        fontSize: 16,
                                      ),
                                    ),
                                    minLeadingWidth: 10,
                                  ),
                                ),
                          GestureDetector(
                            onTap: model.signOut,
                            child: ListTile(
                              title: Text(
                                'Logout',
                                style: GoogleFonts.montserrat(
                                  color: const Color(0xff414141),
                                  fontSize: 16,
                                ),
                              ),
                              leading: const Icon(
                                Icons.logout_outlined,
                                size: 26,
                                color: Color(0xffcccccc),
                              ),
                              minLeadingWidth: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

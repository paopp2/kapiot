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
    final currentUserInfo = ref.watch(currentUserInfoProvider).data?.value;
    final username = currentUser.email!.split('@').first;
    // User is a student if username can be parsed as int (ID number)
    final isStudent = (int.tryParse(username) != null);
    return SizedBox(
      width: constraints.maxWidth * 0.85,
      height: constraints.maxHeight,
      child: Drawer(
        child: (currentUserInfo == null)
            ? const Center(
                child: Text("No user info set"),
              )
            : Column(
                children: [
                  Container(
                    width: constraints.maxWidth * 0.85,
                    height: constraints.maxHeight * 0.3,
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
                                backgroundImage:
                                    NetworkImage(currentUser.photoUrl!),
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
                    height: constraints.maxHeight * 0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: currentUserInfo.isRegisteredDriver,
                            child: const ListTile(
                              title: Text('Rating'),
                              leading: Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              trailing: Text('4.8'),
                            ),
                          ),
                          ListTile(
                            title: const Text('Points'),
                            leading: const Icon(Icons.score),
                            trailing: Text('${currentUserInfo.points.toInt()}'),
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
                                    horizontal: constraints.maxWidth * 0.025,
                                  ),
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            constraints.maxWidth * 0.025,
                                      ),
                                      width: constraints.maxWidth * 0.3,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Home'),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            constraints.maxWidth * 0.025,
                                      ),
                                      width: constraints.maxWidth * 0.3,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child:
                                            Text(isStudent ? 'School' : 'Work'),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            constraints.maxWidth * 0.025,
                                      ),
                                      width: constraints.maxWidth * 0.3,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Icon(Icons.add),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[400],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          currentUserInfo.isRegisteredDriver
                              ? ExpansionTile(
                                  leading: const Icon(Icons.drive_eta),
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
                                                    constraints.maxWidth *
                                                        0.025,
                                              ),
                                              height:
                                                  constraints.maxHeight * 0.2,
                                              width: constraints.maxWidth * 0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                  child: const ListTile(
                                    leading: Icon(Icons.drive_eta),
                                    title: Text(
                                      'Register as Driver',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ),
                          GestureDetector(
                            onTap: model.signOut,
                            child: const ListTile(
                              title: Text('Logout'),
                              leading: Icon(Icons.logout_outlined),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final currentUserInfo = ref.watch(currentUserInfoProvider).data?.value;
    return SizedBox(
      width: constraints.maxWidth * 0.85,
      height: constraints.maxHeight,
      child: Drawer(
        child: (currentUserInfo == null)
            ? const Center(child: Text("No user info set"))
            : Column(
                children: [
                  UserInfoDrawerHeader(constraints: constraints),
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
                            child: ListTile(
                              title: const Text('Rating'),
                              leading: const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              trailing: Text(
                                currentUserInfo.driverInfo!.averageRating,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text('Points'),
                            leading: const Icon(Icons.score),
                            trailing: Text('${currentUserInfo.points.toInt()}'),
                          ),
                          GestureDetector(
                            onTap: model.gotoPlaceManagerView,
                            child: const ListTile(
                              title: Text('My Locations'),
                              leading: Icon(Icons.map),
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

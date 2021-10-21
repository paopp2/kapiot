import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';

class UserInfoDrawerHeader extends HookConsumerWidget {
  const UserInfoDrawerHeader({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider)!;
    final username = currentUser.email!.split('@').first;
    return Container(
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
    );
  }
}

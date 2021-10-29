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
      height: constraints.maxHeight * 0.3,
      width: constraints.maxWidth * 0.85,
      color: const Color(0xfff5f5f5),
      padding: EdgeInsets.only(
        left: constraints.maxWidth * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              vertical: constraints.maxHeight * 0.03,
            ),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF5F45A4),
              radius: 48,
              child: CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(currentUser.photoUrl!),
              ),
            ),
          ),
          Text(
            currentUser.displayName!,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: const Color(0xFF404040),
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
          Text(
            username,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: const Color(0xFFa4a4a4),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_state.dart';

class RewardPointsBackdrop extends HookConsumerWidget {
  const RewardPointsBackdrop({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(pointsProvider);
    return Entry(
      yOffset: (constraints.maxHeight / 2) - (constraints.maxHeight * 0.35 / 2),
      delay: const Duration(milliseconds: 1500),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInToLinear,
      child: Container(
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
    );
  }
}

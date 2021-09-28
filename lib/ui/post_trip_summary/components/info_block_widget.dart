import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBlockWidget extends StatelessWidget {
  const InfoBlockWidget({
    Key? key,
    required this.constraints,
    required this.number,
    required this.type,
  }) : super(key: key);

  final BoxConstraints constraints;
  final double number;
  final String type;

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
        color: const Color(0xffedd9e9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedFlipCounter(
            value: number,
            fractionDigits: (type == 'km') ? 1 : 0,
            duration: const Duration(milliseconds: 3500),
            curve: Curves.linearToEaseOut,
            textStyle: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: const Color(0xff574754),
            ),
          ),
          Text(
            type,
            style: GoogleFonts.poppins(
              height: 0.5,
              fontSize: 12,
              color: const Color(0xff997d94),
            ),
          ),
        ],
      ),
    );
  }
}

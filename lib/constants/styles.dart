import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static final priLargeSizedText = GoogleFonts.poppins(
    fontSize: 34,
    letterSpacing: 2,
    color: const Color(0xff333333),
  );

  static final priMiddleSizedText = GoogleFonts.poppins(
    fontSize: 16,
    color: const Color(0xff414141),
  );

  static final secMiddleSizedText = GoogleFonts.montserrat(
    color: const Color(0xff414141),
    fontSize: 16,
  );

  static final secSmallSizedText = GoogleFonts.montserrat(
    color: const Color(0xff333333),
    fontSize: 13,
  );
}

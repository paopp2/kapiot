import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
    this.text,
  }) : super(key: key);
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const SpinKitChasingDots(
              color: Color(0xFF5F45A4),
              size: 40,
            ),
          ),
          Visibility(
            visible: text != null,
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: const Color(0xff666666),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

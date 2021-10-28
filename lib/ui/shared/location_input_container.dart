import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationInputContainer extends StatelessWidget {
  const LocationInputContainer({
    Key? key,
    required this.constraints,
    required this.onPressed,
    required this.leadingIcon,
    required this.text,
    required this.hint,
  }) : super(key: key);

  final BoxConstraints constraints;
  final void Function() onPressed;
  final IconData leadingIcon;
  final String? text;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.025,
        vertical: constraints.maxHeight * 0.015,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: constraints.maxWidth * 0.03),
              child: Icon(
                leadingIcon,
                color: const Color(0xFF716bfd),
                size: 27,
              ),
            ),
            Expanded(
              child: Text(
                text ?? hint,
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  color: (text != null)
                      ? const Color(0xff333333)
                      : const Color(0xffaaaaaa),
                ),
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

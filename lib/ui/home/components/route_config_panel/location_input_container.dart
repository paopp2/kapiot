import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  text ?? hint,
                  style: TextStyle(
                    fontSize: 17,
                    color: (text != null) ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

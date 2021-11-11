import 'package:flutter/material.dart';

class PassengerCircleAvatar extends StatelessWidget {
  const PassengerCircleAvatar({
    Key? key,
    required this.photoUrl,
  }) : super(key: key);

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Align(
      widthFactor: 0.8,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 33,
        child: Container(
          width: 60,
          child: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(photoUrl),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF5F45A4),
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

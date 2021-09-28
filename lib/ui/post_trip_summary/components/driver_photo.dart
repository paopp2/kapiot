import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class DriverPhoto extends StatelessWidget {
  const DriverPhoto({
    Key? key,
    required this.driver,
    required this.constraints,
  }) : super(key: key);

  final KapiotUser driver;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (constraints.maxHeight * 0.35) - 40,
      left: (constraints.maxWidth / 2) - 40,
      child: Entry.scale(
        delay: const Duration(milliseconds: 2000),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInToLinear,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(40),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 40,
            child: CircleAvatar(
              radius: 37,
              backgroundImage: NetworkImage(
                driver.photoUrl ?? uscLogo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final LoginViewModel model;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        child: OutlinedButton.icon(
          label: const Text(
            "Sign in with USC Email",
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          onPressed: model.signInWithGoogle,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(width: 1),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: const BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
      );
}

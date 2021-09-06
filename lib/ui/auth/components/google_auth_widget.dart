import 'package:flutter/material.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final LoginViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      child: OutlinedButton.icon(
        label: const Text(
          "Log in with USC Email",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        icon: Image.asset(
          'lib/ui/assets/icons/google.png',
          width: 25,
          height: 25,
        ),
        onPressed: model.signInWithGoogle,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          side: MaterialStateProperty.all(
              BorderSide(color: Colors.grey.shade300)),
          shadowColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: const BorderSide(color: Color(0xffffc90e)),
            ),
          ),
        ),
      ),
    );
  }
}

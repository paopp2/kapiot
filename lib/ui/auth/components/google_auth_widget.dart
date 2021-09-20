import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';

class GoogleAuthWidget extends StatelessWidget {
  const GoogleAuthWidget({
    Key? key,
    required this.model,
    required this.constraints,
  }) : super(key: key);
  final LoginViewModel model;
  final BoxConstraints constraints;

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
          'assets/icons/google.png',
          width: 25,
          height: 25,
        ),
        onPressed: () => model.signInWithGoogle(
          context: context,
          nonUscEmailDialog: AlertDialog(
            title: const Text(
              "Oops!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xffffc901),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/error_non_usc_email.png',
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: constraints.maxHeight * 0.05,
                    bottom: constraints.maxHeight * 0.02,
                  ),
                  child: const Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'It seems like the account used is not affiliated with the USC community.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34),
            ),
            elevation: 0,
          ),
        ),
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

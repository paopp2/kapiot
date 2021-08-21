import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(loginViewModel);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  GoogleAuthWidget(),
                  SizedBox(height: 12),
                  Text(
                    "Login to continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  // ElevatedButton.icon(
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.white,
                  //     onPrimary: Colors.black,
                  //     minimumSize: const Size(double.infinity, 50),
                  //   ),
                  //   // icon: const Icon(FontAwesomeIcons.google),
                  //   icon: const Icon(Icons.enhanced_encryption_outlined),
                  //   label: const Text('Sign In with Google'),
                  //   onPressed: model.signInWithGoogle,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GoogleAuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: OutlinedButton.icon(
          label: Text(
            "Sign in with Google",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          icon: FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          onPressed: () {
            print("insert here model.signInWithGoogle");
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            ),
            side: MaterialStateProperty.all(
              BorderSide(width: 1),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
      );
}

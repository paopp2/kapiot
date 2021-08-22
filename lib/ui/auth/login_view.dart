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
                  const Spacer(
                    flex: 3,
                  ),
                  GoogleAuthWidget(
                    model: model,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Login to continue",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
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
            "Sign in with Google",
            style: TextStyle(
              fontWeight: FontWeight.bold,
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

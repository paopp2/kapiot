import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    // icon: const Icon(FontAwesomeIcons.google),
                    icon: const Icon(Icons.enhanced_encryption_outlined),
                    label: const Text('Sign In with Google'),
                    onPressed: model.signInWithGoogle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

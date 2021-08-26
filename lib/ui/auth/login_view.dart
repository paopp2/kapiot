import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/auth/login_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kapiot/ui/auth/components/google_auth_widget.dart';

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
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxHeight * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                const Image(
                  image: AssetImage('lib/ui/assets/images/usc_logo.png'),
                  width: 70,
                ),
                const Text(
                  'kapiot',
                  style: TextStyle(
                      fontSize: 84,
                      fontFamily: 'Sanz',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 7,
                      color: Color(0xff5eab53)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'University of San Carlos',
                    style: TextStyle(
                      letterSpacing: 3.5,
                      fontSize: 18,
                      fontFamily: 'Vegur',
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(flex: 2),
                GoogleAuthWidget(model: model),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}

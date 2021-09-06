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

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.15),
                  child: const Image(
                    image: AssetImage('lib/ui/assets/images/usc_logo.png'),
                    width: 70,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.1),
                  child: Column(
                    children: [
                      const Text(
                        'kapiot',
                        style: TextStyle(
                            fontSize: 84,
                            fontFamily: 'Sanz',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 7,
                            color: Color(0xffffc901)),
                        // color: Color(0xff5eab53)),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
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
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: BackgroundClipper(),
                        child: Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color(0xffffc901),
                                Color(0xffffd94e)
                              ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.05),
                          child: GoogleAuthWidget(model: model),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.8);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // path.lineTo(x, y)

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

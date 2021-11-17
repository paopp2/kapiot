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
                  margin: EdgeInsets.only(
                    top: constraints.maxHeight * 0.15,
                    bottom: constraints.maxHeight * 0.2,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160,
                        child: Stack(
                          children: const [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image(
                                image: AssetImage(
                                  'assets/logo/kapiot_logo_white.png',
                                ),
                                width: 70,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'kapiot',
                                style: TextStyle(
                                  fontSize: 70,
                                  fontFamily: 'NooplaRegular',
                                  letterSpacing: 7,
                                  color: Color(0xFF5F45A4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.01,
                      ),
                      const Center(
                        child: Text(
                          'University of San Carlos',
                          style: TextStyle(
                            letterSpacing: 3,
                            fontSize: 16,
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
                              colors: [Color(0xFF5F45A4), Color(0xFFCFC7E3)],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        size: const Size(400, 400),
                        painter: CurvedPainter(),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                            bottom: constraints.maxHeight * 0.15,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.05,
                          ),
                          child: GoogleAuthWidget(
                            model: model,
                            constraints: constraints,
                          ),
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
    path.moveTo(0, size.height * 0.4);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = const Color(0xFF5F45A4);
    var path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.9);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

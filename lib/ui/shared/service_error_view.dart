import 'package:flutter/material.dart';

class MissingServiceView extends StatelessWidget {
  const MissingServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return const Scaffold(
        body: Center(
          child: Text("Missing services..."),
        ),
      );
    });
  }
}

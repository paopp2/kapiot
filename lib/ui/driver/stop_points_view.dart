import 'package:flutter/material.dart';

class StopPointsView extends StatelessWidget {
  const StopPointsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Colors.blue,
          ),
        );
      },
    );
  }
}

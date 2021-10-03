import 'package:flutter/material.dart';

class DriverRegisterView extends StatelessWidget {
  const DriverRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const Scaffold(
          body: Center(
            child: Text('driver register view'),
          ),
        );
      },
    );
  }
}

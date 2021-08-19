import 'package:flutter/material.dart';

class RiderManagerView extends StatelessWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Colors.red,
          ),
        );
      },
    );
  }
}

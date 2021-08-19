import 'package:flutter/material.dart';

class RequestAcceptedView extends StatelessWidget {
  const RequestAcceptedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Colors.yellow,
          ),
        );
      },
    );
  }
}

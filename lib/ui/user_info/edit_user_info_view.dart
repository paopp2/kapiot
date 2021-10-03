import 'package:flutter/material.dart';

class EditUserInfoView extends StatelessWidget {
  const EditUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const Scaffold(
          body: Center(
            child: Text('Edit user info view'),
          ),
        );
      },
    );
  }
}

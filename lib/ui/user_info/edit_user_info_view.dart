import 'package:flutter/material.dart';

class EditUserInfoView extends StatelessWidget {
  const EditUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Course and year (eg. BS CPE 3)',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Default start location',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Default end location',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

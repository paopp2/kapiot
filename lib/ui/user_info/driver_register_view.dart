import 'package:flutter/material.dart';

class DriverRegisterView extends StatelessWidget {
  const DriverRegisterView({Key? key}) : super(key: key);

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
                  decoration: InputDecoration(hintText: 'License plate'),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Car make and model (eg. Suzuki Ertiga)',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Car type (Sedan, Pickup, Hatchback, SUV, etc.)',
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

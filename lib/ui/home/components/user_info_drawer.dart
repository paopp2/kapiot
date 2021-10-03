import 'package:flutter/material.dart';

class UserInfoDrawer extends StatelessWidget {
  const UserInfoDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(child: Text('Kapiot (Drawer Header)')),
          const Text('Email: email@usc.edu.ph'),
          const Text('Course and year: BS CPE 3'),
          const Text('Default start: Aldea Del Sol Bankal Lapu-lapu'),
          const Text('Default end: Sunny Hills Talamban'),
          const SizedBox(height: 20),
          const Text('-----IF NOT DRIVER-----'),
          TextButton(
            child: const Text('Register as Driver'),
            onPressed: () {},
          ),
          const Text('-----IF DRIVER-----'),
          const Text('Rating: 4.5'),
          const Text('License plate: ABC 069'),
          const Text('Car make and model: Suzuki Ertiga'),
          const Text('Car type: AUV'),
          const Spacer(),
          TextButton(
            child: const Text('Edit user info'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

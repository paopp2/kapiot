import 'package:flutter/material.dart';

class PostTripSummaryView extends StatelessWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('CES: 69'),
                const Text('Origin: Eskina Japan'),
                const Text('Destination: Eskina Singapore'),
                const Text('Duration: 69mins'),
                const Text('Distance: 69km'),
                const Text('Driver: '),
                const Text('Riders: '),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Back to HomeView'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

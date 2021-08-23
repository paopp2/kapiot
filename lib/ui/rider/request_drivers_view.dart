import 'package:flutter/material.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';

class RequestDriversView extends StatelessWidget {
  const RequestDriversView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: KapiotSlidingPanel(
            constraints: constraints,
            title: "We found n drivers for your request",
            map: const Center(
              child: Text('Here lies Map'),
            ),
            panel: SizedBox(
              width: double.infinity,
              height: 330,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    width: 240,
                    color: Colors.grey[100],
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        const Text('Paolo Pepito'),
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () {
                            print("hailed");
                          },
                          child: const Text('Hail Ride'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 240,
                    color: Colors.grey[100],
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        const Text('Charles Ausejo'),
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () {
                            print("hailed");
                          },
                          child: const Text('Hail Ride'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 240,
                    color: Colors.grey[100],
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        const Text('Blithe Gonzales'),
                        const SizedBox(height: 70),
                        ElevatedButton(
                          onPressed: () {
                            print("hailed");
                          },
                          child: const Text('Hail Ride'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

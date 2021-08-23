import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:kapiot/ui/general_components/sliding_up_panel_widget.dart';

class RequestDriversView extends StatelessWidget {
  const RequestDriversView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SlidingUpPanel(
            minHeight: constraints.maxHeight * 0.1,
            maxHeight: constraints.maxHeight * 0.55,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            body: const Expanded(
              child: Center(
                child: Text('Here lies Map'),
              ),
            ),
            panelBuilder: (controller) => PanelWidget(
              controller: controller,
              column: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('We found n drivers for your request '),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 330,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(20),
                      children: <Widget>[
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
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

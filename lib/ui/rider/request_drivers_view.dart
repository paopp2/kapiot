import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RequestDriversView extends StatelessWidget {
  const RequestDriversView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final panelHeightOpened = MediaQuery.of(context).size.height * 0.55;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SlidingUpPanel(
            minHeight: panelHeightClosed,
            maxHeight: panelHeightOpened,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            body: Expanded(
              child: Container(
                child: Center(
                  child: Text("Here lies Map"),
                ),
              ),
            ),
            panelBuilder: (controller) => PanelWidget(
              controller: controller,
            ),
          ),
        );
      },
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              buildDragHandle(),
              SizedBox(
                height: 25,
              ),
              Text("We found n drivers for your request "),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 330,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(20),
                  children: [
                    Container(
                      width: 240,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                            child: Text("Hail Ride"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 240,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                            child: Text("Hail Ride"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 240,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
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
                            child: Text("Hail Ride"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      );
}

Widget buildDragHandle() => Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
    );

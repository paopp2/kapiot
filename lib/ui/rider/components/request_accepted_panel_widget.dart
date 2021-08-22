import 'package:flutter/material.dart';
import 'drag_handle_widget.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            buildDragHandle(),
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text("Ride Information"),
                  SizedBox(height: 25),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text('Paolo Pepito')
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.grey.shade200),
                    height: 210,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text("Your co passengers for this ride"),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Rider's reviews"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:kapiot/ui/general_components/sliding_up_panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RequestAcceptedView extends StatelessWidget {
  const RequestAcceptedView({Key? key}) : super(key: key);

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
                child: Text("Here lies Map"),
              ),
            ),
            panelBuilder: (controller) => PanelWidget(
              controller: controller,
              column: Column(
                children: [
                  Column(
                    children: const <Widget>[
                      SizedBox(height: 20),
                      Text('Ride Information'),
                      SizedBox(height: 25),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue,
                      ),
                      SizedBox(height: 10),
                      Text('Paolo Pepito')
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                            color: Colors.grey.shade200),
                        height: constraints.maxHeight * 0.28,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                              child: Text('Your co passengers for this ride'),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
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
                        height: constraints.maxHeight * 0.12,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text("Rider's reviews"),
                          ],
                        ),
                      ),
                    ],
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

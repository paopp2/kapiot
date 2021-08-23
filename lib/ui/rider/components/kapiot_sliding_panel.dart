import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class KapiotSlidingPanel extends StatelessWidget {
  const KapiotSlidingPanel(
      {Key? key,
      required this.map,
      required this.child,
      required this.constraints})
      : super(key: key);
  final Widget map;
  final Widget child;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: constraints.maxHeight * 0.1,
      maxHeight: constraints.maxHeight * 0.55,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      body: map,
      panelBuilder: (controller) {
        return Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12)),
              ),
              child,
            ],
          ),
        );
      },
    );
  }
}

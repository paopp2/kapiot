import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class KapiotSlidingPanel extends StatelessWidget {
  const KapiotSlidingPanel({
    Key? key,
    required this.map,
    required this.panel,
    required this.constraints,
    required this.title,
  }) : super(key: key);
  final Widget map;
  final Widget panel;
  final BoxConstraints constraints;
  final String title;

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
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(title),
              const SizedBox(
                height: 20,
              ),
              panel,
            ],
          ),
        );
      },
    );
  }
}

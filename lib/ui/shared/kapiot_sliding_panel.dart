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
      defaultPanelState: PanelState.OPEN,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      backdropEnabled: true,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      body: map,
      panelBuilder: (controller) {
        return Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.01,
              ),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.03),
                child: Text(title),
              ),
              panel,
            ],
          ),
        );
      },
    );
  }
}

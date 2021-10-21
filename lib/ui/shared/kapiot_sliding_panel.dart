import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class KapiotSlidingPanel extends StatelessWidget {
  const KapiotSlidingPanel({
    Key? key,
    required this.map,
    required this.panel,
    required this.constraints,
    required this.panelHeight,
  }) : super(key: key);
  final Widget map;
  final Widget panel;
  final BoxConstraints constraints;
  final double panelHeight;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      minHeight: constraints.maxHeight * 0.125,
      maxHeight: panelHeight,
      body: Container(
        height: constraints.maxHeight,
        color: const Color(0xfff8f9fa),
        child: Column(
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.875,
              child: map,
            ),
          ],
        ),
      ),
      panelBuilder: (controller) {
        return Container(
          width: constraints.maxWidth,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.01),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              panel,
            ],
          ),
        );
      },
    );
  }
}

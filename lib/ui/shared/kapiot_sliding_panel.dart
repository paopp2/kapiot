import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class KapiotSlidingPanel extends StatelessWidget {
  const KapiotSlidingPanel({
    Key? key,
    required this.map,
    required this.panel,
    required this.constraints,
  }) : super(key: key);
  final Widget map;
  final Widget panel;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      defaultPanelState: PanelState.OPEN,
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      minHeight: constraints.maxHeight * 0.1,
      maxHeight: constraints.maxHeight * 0.5,
      body: Container(
        height: constraints.maxHeight,
        color: const Color(0xfff8f9fa),
        child: Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.9, child: map),
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
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.02),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(
              //     vertical: constraints.maxHeight * 0.03,
              //   ),
              //   child: Text(title),
              // ),
              panel,
            ],
          ),
        );
      },
    );
  }
}

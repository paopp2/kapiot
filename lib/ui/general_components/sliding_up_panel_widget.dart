import 'package:flutter/material.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final Column column;

  const PanelWidget({
    Key? key,
    required this.controller,
    required this.column,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(
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
            column,
          ],
        ),
      );
}

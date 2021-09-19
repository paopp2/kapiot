import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.025),
      child: const Divider(
        color: Colors.grey,
        thickness: 0.5,
        height: 0.05,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/ui/home/components/route_config_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final BoxConstraints constraints;
  final HomeViewModel model;
  const PanelWidget(
      {Key? key,
      required this.controller,
      required this.constraints,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RouteConfigPanel(
      constraints: constraints,
      model: model,
    );
  }
}

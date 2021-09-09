import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/ui/home/components/route_config_panel/config_type_panel.dart';

class RouteConfigPanel extends HookConsumerWidget {
  RouteConfigPanel({
    Key? key,
    required this.constraints,
    required this.model,
  }) : super(key: key);

  final BoxConstraints constraints;
  final HomeViewModel model;
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ConfigTypePanel(
            pageController: pageController,
            isRider: true,
            model: model,
            constraints: constraints,
          ),
          ConfigTypePanel(
            pageController: pageController,
            isRider: false,
            model: model,
            constraints: constraints,
          )
        ],
      ),
    );
  }
}

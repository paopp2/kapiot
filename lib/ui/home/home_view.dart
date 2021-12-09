import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/ui/home/components/route_config_panel/route_config_panel.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';
import 'components/home_view_map.dart';
import 'components/user_info_drawer/user_info_drawer.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final model = ref.watch(homeViewModel);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            drawer: UserInfoDrawer(model: model, constraints: constraints),
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Color(0xFF5F45A4),
              ),
              toolbarHeight: constraints.maxHeight * 0.08,
              title: const Text(
                'kapiot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'NooplaRegular',
                  color: Color(0xFF5F45A4),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: KapiotSlidingPanel(
              constraints: constraints,
              panelHeight: constraints.maxHeight * 0.5,
              map: HomeViewMap(model: model),
              panel: RouteConfigPanel(
                constraints: constraints,
                model: model,
              ),
            ),
          );
        },
      ),
    );
  }
}

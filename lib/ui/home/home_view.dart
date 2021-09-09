import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core_providers/auth_providers.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/ui/home/components/route_config_panel.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';
import 'components/home_view_map.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final model = ref.watch(homeViewModel);
    final resetKey = ref.watch(resetKeyProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, [resetKey]);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              toolbarHeight: constraints.maxHeight * 0.08,
              centerTitle: true,
              title: const Text(
                'kapiot',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontFamily: 'Sanz',
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffc901),
                  // Color(0xff808080),
                ),
              ),
              actions: [
                Container(
                  width: 50,
                  margin: EdgeInsets.only(
                    right: constraints.maxWidth * 0.025,
                  ),
                  decoration: const BoxDecoration(
                      color: Color(0x5f808080), shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 25,
                    ),
                    onPressed: model.signOut,
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: KapiotSlidingPanel(
              constraints: constraints,
              title: "Route Configuration",
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

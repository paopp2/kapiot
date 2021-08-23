import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/ui/home/components/route_config_panel.dart';
import 'package:kapiot/ui/general/kapiot_sliding_panel.dart';
import 'components/google_map_section.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final model = ref.watch(homeViewModelProvider);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: model.signOut,
              )
            ],
          ),
          body: KapiotSlidingPanel(
            constraints: constraints,
            title: "Route Configuration",
            map: GoogleMapSection(model: model),
            panel: RouteConfigPanel(
              constraints: constraints,
              model: model,
            ),
          ),
        );
      },
    );
  }
}

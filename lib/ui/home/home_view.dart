import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

import 'components/google_map_section.dart';
import 'components/route_config_panel.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(homeViewModelProvider);
    final cameraPosition = ref.watch(cameraPositionProvider).state;
    final isRider = ref.watch(isRiderSelectedProvider).state;
    final riderCount = ref.watch(riderCountProvider).state;
    final dateTime = ref.watch(dateTimeProvider).state;

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
          body: Stack(
            children: [
              GoogleMapSection(
                model: model,
                camPosition: cameraPosition,
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: RouteConfigPanel(
                  constraints: constraints,
                  model: model,
                  isRider: isRider,
                  riderCount: riderCount,
                  dateTime: dateTime,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

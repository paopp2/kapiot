import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'components/google_map_section.dart';
import 'components/panel_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          body: SlidingUpPanel(
            minHeight: constraints.maxHeight * 0.1,
            maxHeight: constraints.maxHeight * 0.55,
            parallaxEnabled: true,
            parallaxOffset: 0.6,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            body: Expanded(
              child: Column(
                children: [
                  Expanded(child: GoogleMapSection(model: model)),
                ],
              ),
            ),
            panelBuilder: (controller) => PanelWidget(
              controller: controller,
              constraints: constraints,
              model: model,
            ),
          ),
        );
      },
    );
  }
}

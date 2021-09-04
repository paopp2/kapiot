import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';

import 'components/requesting_riders_panel.dart';
import 'components/stop_point_panel.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    final nextStop = ref.watch(nextStopProvider).state;

    double height;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        (nextStop != null)
            ? height = constraints.maxHeight * 0.5
            : height = constraints.maxHeight * 0.9;
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Map View"),
              icon: const Icon(Icons.map),
            ),
            body: Container(
              color: const Color(0x7679ADFf),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (nextStop != null)
                        ? StopPointPanel(
                            model: model,
                            constraints: constraints,
                            nextStop: nextStop,
                          )
                        : const SizedBox(),
                    RequestingRidersPanel(
                      model: model,
                      constraints: constraints,
                      height: height,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

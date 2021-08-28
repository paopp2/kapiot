import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';

import 'components/requesting_riders_panel.dart';
import 'components/stop_point_panel.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("Map View"),
            icon: const Icon(Icons.map),
          ),
          body: Container(
            color: const Color(0x7679ADFf),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StopPointPanel(model: model),
                  const SizedBox(height: 15),
                  RequestingRidersPanel(model: model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

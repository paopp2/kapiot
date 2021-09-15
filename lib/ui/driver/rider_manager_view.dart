import 'package:dartz/dartz.dart';
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

    // print('flag is $flag');
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          (nextStop == null)
              ? height = constraints.maxHeight * 0.4
              : height = constraints.maxHeight * 0.15;
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  (nextStop == null)
                      ? const SizedBox() 
                      : StopPointPanel(
                          model: model,
                          constraints: constraints,
                          nextStop: nextStop,
                        ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    width: constraints.maxWidth,
                    color: Colors.amber,
                    child: const Center(child: Text('Map here')),
                  ),
                  RequestingRidersPanel(
                    model: model,
                    constraints: constraints,
                    height: height,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

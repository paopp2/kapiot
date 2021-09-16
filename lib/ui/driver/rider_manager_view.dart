import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.81,
                        child: const GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              10.367889719519498,
                              123.91382842505321,
                            ),
                            zoom: 20,
                          ),
                        ),
                      ),
                      StopPointPanel(constraints: constraints),
                    ],
                  ),
                  RequestingRidersPanel(
                    constraints: constraints,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

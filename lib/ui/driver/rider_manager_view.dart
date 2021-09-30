import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/ui/driver/components/rider_manager_view_map.dart';

import 'components/requesting_riders_panel.dart';
import 'components/stop_point_panel.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    final nextStop = ref.watch(nextStopProvider).state;
    final driverPoints = ref.watch(driverPointsProvider).state;

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
              child: Stack(
                children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.transparent],
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: RiderManagerViewMap(model: model),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: constraints.maxHeight * 0.015,
                          ),
                          height: constraints.maxHeight * 0.055,
                          width: constraints.maxWidth * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  right: constraints.maxWidth * 0.01,
                                ),
                                child: Image.asset(
                                  'assets/icons/assist_points.png',
                                  color: Colors.white,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Text(
                                driverPoints.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        (nextStop != null)
                            ? StopPointPanel(
                                model: model,
                                constraints: constraints,
                                nextStop: nextStop,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: constraints.maxHeight * 0.025,
                    child: RequestingRidersPanel(
                      model: model,
                      constraints: constraints,
                    ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/ui/driver/components/rider_manager_view_map.dart';

import 'components/requesting_riders_panel.dart';
import 'components/stop_point_panel.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    final currentDriverConfig =
        ref.watch(currentRouteConfigProvider).state as ForDriver;
    final maxRiderCount = currentDriverConfig.maxRiderCount;
    final currentRiderCount = currentDriverConfig.currentRiderCount;
    final nextStop = ref.watch(nextStopProvider).state;
    final driverPoints = ref.watch(driverPointsProvider).state;
    final acceptedRidersStream = ref.watch(acceptedRidersStreamProvider);
    final expand = useState(false);

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
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment(0.0, 0.5),
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.transparent],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: RiderManagerViewMap(model: model),
                  ),
                  SizedBox(
                    width: constraints.maxWidth,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => (expand.value = !expand.value),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInToLinear,
                            margin: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.015,
                            ),
                            height:
                                expand.value ? constraints.maxHeight * 0.3 : 50,
                            width:
                                expand.value ? constraints.maxWidth * 0.8 : 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: constraints.maxWidth * 0.01,
                                        ),
                                        child: Image.asset(
                                          'assets/icons/assist_points.png',
                                          color: Colors.black,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Text(
                                        driverPoints.toStringAsFixed(2),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      // TODO: Replace with better design for showing
                                      // current car capacity
                                      const SizedBox(width: 5),
                                      Text(
                                        '$currentRiderCount/$maxRiderCount',
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                expand.value
                                    ? Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 100,
                                          child: acceptedRidersStream.when(
                                            error: (_, __) => const SizedBox(),
                                            loading: () => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            data: (acceptedRiders) {
                                              return ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    acceptedRiders.length,
                                                itemBuilder: (context, index) {
                                                  final rider =
                                                      acceptedRiders[index];
                                                  return Card(
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          rider.photoUrl!,
                                                        ),
                                                      ),
                                                      title: Text(
                                                        rider.displayName ?? '',
                                                        overflow:
                                                            TextOverflow.fade,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                      ),
                                                      subtitle: Text(
                                                        rider.userType!
                                                            .description,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
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

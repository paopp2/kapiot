import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/ui/driver/components/rider_manager_view_map.dart';

import 'components/drive_info_panel.dart';
import 'components/requesting_riders_panel.dart';
import 'components/stop_point_panel.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    final nextStop = ref.watch(nextStopProvider).state;
    final requestingRidersStream = ref.watch(requestingRidersStreamProvider);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: constraints.maxHeight * 0.8,
                          child: ShaderMask(
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
                        ),
                        Container(
                          height: constraints.maxHeight * 0.2,
                          color: Colors.white,
                          child: (requestingRidersStream.data?.value.isEmpty ??
                                  true)
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No Ride Requests',
                                        style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          color: const Color(0xFF333333),
                                        ),
                                      ),
                                      Text(
                                        "When Carolinians along your\nroute send you hail requests, you'll see them here.",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: const Color(0xFFAAAAAA),
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                )
                              : RequestingRidersPanel(
                                  model: model,
                                  constraints: constraints,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          DriveInfoPanel(constraints: constraints),
                          (nextStop != null)
                              ? StopPointPanel(
                                  model: model,
                                  constraints: constraints,
                                  nextStop: nextStop,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

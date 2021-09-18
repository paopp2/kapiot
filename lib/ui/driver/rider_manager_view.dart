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
            // extendBodyBehindAppBar: true,
            // appBar: AppBar(
            //   // iconTheme: const IconThemeData(color: Colors.black),
            //   // toolbarHeight: constraints.maxHeight * 0.8,
            //   backgroundColor: Colors.transparent,
            //   title: Text('Points'),
            //   centerTitle: true,
            //   elevation: 0,
            //   automaticallyImplyLeading: false,
            // ),
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.8,
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
                      SizedBox(
                        height: constraints.maxHeight * 0.25,
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overScroll) {
                            overScroll.disallowGlow();
                            return true;
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                toolbarHeight: constraints.maxHeight * 0.075,
                                snap: true,
                                floating: true,
                                backgroundColor: Colors.transparent,
                                title: Container(
                                  height: constraints.maxHeight * 0.055,
                                  width: constraints.maxWidth * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
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
                                          'lib/ui/assets/icons/assist_points.png',
                                          color: Colors.white,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      const Text(
                                        '6.78',
                                      ),
                                    ],
                                  ),
                                ),
                                centerTitle: true,
                                elevation: 0,
                                automaticallyImplyLeading: false,
                              ),
                              SliverToBoxAdapter(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: constraints.maxHeight * 0.02,
                                    ),
                                    StopPointPanel(constraints: constraints),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.05,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  RequestingRidersPanel(
                    constraints: constraints,
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

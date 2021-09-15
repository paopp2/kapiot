import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/ui/rider/request_accepted/components/request_accepted_map.dart';
import 'package:kapiot/ui/rider/request_accepted/components/ride_info_panel.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';

class RequestAcceptedView extends HookConsumerWidget {
  const RequestAcceptedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(requestAcceptedViewModel);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            body: KapiotSlidingPanel(
              constraints: constraints,
              title: 'Ride Information',
              map: Center(
                child: RequestAcceptedViewMap(model: model),
              ),
              panel: RideInfoPanel(
                model: model,
                constraints: constraints,
              ),
            ),
          );
        },
      ),
    );
  }
}

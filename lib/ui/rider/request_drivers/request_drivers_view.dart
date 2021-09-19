import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/ui/rider/request_drivers/components/driver_card_stream.dart';
import 'package:kapiot/ui/rider/request_drivers/components/request_drivers_map.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';

class RequestDriversView extends HookConsumerWidget {
  const RequestDriversView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(requestDriversViewModel);

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
              panelHeight: constraints.maxHeight * 0.5,
              map: Center(
                child: RequestDriversViewMap(model: model),
              ),
              panel: Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.05,
                  ),
                  width: double.infinity,
                  child: DriverCardStream(
                    model: model,
                    constraints: constraints,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/ui/rider/request_drivers/components/driver_card_stream.dart';
import 'package:kapiot/ui/rider/request_drivers/components/request_drivers_view_map.dart';

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
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.65,
                    child: Center(
                      child: RequestDriversViewMap(model: model),
                    ),
                  ),
                  Container(
                    color: const Color(0xFFF8F9FD),
                    height: constraints.maxHeight * 0.35,
                    width: constraints.maxWidth,
                    child: DriverCardStream(
                      model: model,
                      constraints: constraints,
                    ),
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

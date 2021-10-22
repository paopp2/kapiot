import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/ui/rider/request_drivers/components/driver_card_stream.dart';
import 'package:kapiot/ui/rider/request_drivers/components/request_drivers_view_map.dart';
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
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: AppRouter.instance.popView,
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.blue,
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.65,
                  child: Center(
                    child: RequestDriversViewMap(model: model),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.35,
                  width: constraints.maxWidth,
                  child: DriverCardStream(
                    model: model,
                    constraints: constraints,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

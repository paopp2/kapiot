import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/service_error_handler.dart';

class ServiceErrorView extends HookConsumerWidget {
  const ServiceErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetEnabled = ref.watch(hasNetService).state;
    final locationEnabled = ref.watch(hasLocService).state;
    final hasPermission = ref.watch(hasLocPermission).state;

    return LayoutBuilder(builder: (context, constraints) {
      return WillPopScope(
        onWillPop: () async => false, // Disallow going back from this View
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Internet enabled: $internetEnabled"),
                Text("Location enabled: $locationEnabled"),
                Text("Has location permission: $hasPermission"),
              ],
            ),
          ),
        ),
      );
    });
  }
}

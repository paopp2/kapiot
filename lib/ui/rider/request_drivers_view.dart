import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers_view_model.dart';
import 'package:kapiot/logic/rider/request_drivers_view_state.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';

class RequestDriversView extends HookConsumerWidget {
  const RequestDriversView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(requestDriversViewModel);
    final compatibleDrivers = ref.watch(compatibleDriversStreamProvider);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: KapiotSlidingPanel(
            constraints: constraints,
            title: "We found n drivers for your request",
            map: const Center(
              child: Text('Here lies Map'),
            ),
            panel: SizedBox(
              width: double.infinity,
              height: 330,
              child: compatibleDrivers.when(
                error: (_, __) => const Center(
                  child: Text('Error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (compatibleDrivers) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: compatibleDrivers.length,
                  itemBuilder: (context, index) {
                    final driver = compatibleDrivers[index];
                    return Container(
                      width: 240,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue,
                            backgroundImage: NetworkImage(driver.photoUrl!),
                          ),
                          const SizedBox(height: 10),
                          Text(driver.displayName ?? 'No name'),
                          const SizedBox(height: 70),
                          ElevatedButton(
                            onPressed: () => model.requestDriver(driver.id),
                            child: const Text('Hail Ride'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/ui/shared/kapiot_sliding_panel.dart';

class RequestAcceptedView extends HookConsumerWidget {
  const RequestAcceptedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(requestAcceptedViewModel);
    final acceptingDriver = ref.watch(acceptingDriverProvider).state!;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: KapiotSlidingPanel(
            constraints: constraints,
            title: 'Ride Information',
            map: const Center(
              child: Text('Here lies Map'),
            ),
            panel: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(acceptingDriver.photoUrl!),
                ),
                const SizedBox(height: 10),
                Text(acceptingDriver.displayName!),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: Colors.grey.shade200,
                      ),
                      height: constraints.maxHeight * 0.28,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text('Your co passengers for this ride'),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.12,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Rider's reviews"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

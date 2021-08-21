import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: const Color(0x7679ADFf),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  const Text("Next Stop"),
                  Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: model.acceptedRidersStopPoints.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(
                                        model.acceptedRidersStopPoints[index]
                                            .toString(),
                                        style: const TextStyle(fontSize: 13.0)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Accept'),
                                  ),
                                ],
                              ),
                            );
                          })),
                  Expanded(
                    flex: 4,
                    child: Center(
                      //*! Provider is not final. Temporary only.
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.requestingRiders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(model.requestingRiders[index],
                                        style: const TextStyle(fontSize: 20.0)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Accept'),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

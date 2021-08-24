import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/request_manager_view_state.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';

class RequestingRidersPanel extends HookConsumerWidget {
  const RequestingRidersPanel({
    Key? key,
    required this.model,
  }) : super(key: key);

  final RiderManagerViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestingRidersStream = ref.watch(requestingRidersStreamProvider);

    return Expanded(
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            const Text("REQUESTING RIDERS"),
            Expanded(
              child: requestingRidersStream.when(
                error: (_, __) => const Center(
                  child: Text('Error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (requestingRiders) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: requestingRiders.length,
                  itemBuilder: (context, index) {
                    final rider = requestingRiders[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(rider.photoUrl!),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Text(rider.displayName ?? 'No Name',
                                style: const TextStyle(fontSize: 20.0)),
                          ),
                          ElevatedButton(
                            onPressed: () => model.acceptRider(rider.id),
                            child: const Text('Accept'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/request_manager_view_state.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

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
                loading: () => const LoadingWidget(),
                data: (requestingRiders) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: requestingRiders.length,
                  itemBuilder: (context, index) {
                    final rider = requestingRiders[index];
                    return InkWell(
                      onTap: () => model.acceptRider(rider.id),
                      splashColor: Colors.green[200],
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(rider.photoUrl!),
                          ),
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(rider.displayName ?? 'No Name',
                                style: const TextStyle(fontSize: 20.0)),
                          ),
                        ),
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

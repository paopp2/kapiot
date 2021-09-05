import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

class RequestingRidersPanel extends HookConsumerWidget {
  const RequestingRidersPanel(
      {Key? key,
      required this.model,
      required this.constraints,
      required this.height})
      : super(key: key);

  final RiderManagerViewModel model;
  final BoxConstraints constraints;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestingRidersStream = ref.watch(requestingRidersStreamProvider);

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: const Text(
              "REQUESTING RIDERS",
              style: TextStyle(fontSize: 23),
            ),
          ),
          Container(
            child: requestingRidersStream.when(
              error: (_, __) => const Center(
                child: Text('Error'),
              ),
              loading: () =>
                  const LoadingWidget(text: 'Fetching ride requests...'),
              data: (requestingRiders) => ListView.builder(
                shrinkWrap: true,
                itemCount: requestingRiders.length,
                itemBuilder: (context, index) {
                  final rider = requestingRiders[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: ListTile(
                      onTap: () => model.acceptRider(rider.id),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(rider.photoUrl!),
                      ),
                      title: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(rider.displayName ?? 'No Name',
                            style: const TextStyle(fontSize: 20.0)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class NextStopPointPanel extends HookConsumerWidget {
  const NextStopPointPanel({
    Key? key,
    required this.model,
  }) : super(key: key);

  final RiderManagerViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStop = ref.watch(currentStopProvider).state;
    final rider = currentStop?.rider;

    return Expanded(
      child: (currentStop == null)
          ? const Center(
              child: Text("No stop points"),
            )
          : Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("NEXT STOP POINT"),
                  CircleAvatar(
                    backgroundImage: NetworkImage(rider?.photoUrl ?? uscLogo),
                  ),
                  Text("RIDER: " + (rider?.displayName ?? 'No name')),
                  Text("ACTION: " +
                      ((currentStop.isPickUp) ? "Pick up" : "Drop off")),
                  Text("WHERE: " + (currentStop.stopLocation.address ?? "")),
                  const Text("DISTANCE: 69m"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: model.nextStop,
                        child: const Text("Done"),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

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
    final stopPointsStream = ref.watch(stopPointsStreamProvider);
    final stopPointIndex = ref.watch(stopPointIndexProvider).state;

    return Expanded(
      child: stopPointsStream.when(
        loading: () => const LoadingWidget(text: "Fetching stop points..."),
        error: (_, __) => const Center(child: Text("Error in StopPointPanel")),
        data: (stopPointsList) {
          final stopPoint = stopPointsList[stopPointIndex];
          final rider = stopPoint.rider;
          return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("NEXT STOP POINT"),
                CircleAvatar(
                  backgroundImage: NetworkImage(rider.photoUrl ?? uscLogo),
                ),
                Text("RIDER: " + (rider.displayName ?? 'No name')),
                Text("ACTION: " +
                    ((stopPoint.isPickUp) ? "Pick up" : "Drop off")),
                Text("WHERE: " + stopPoint.stopLocation.address!),
                const Text("DISTANCE: 69m"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () => model.nextStopPoint(stopPoint),
                      child: const Text("Done"),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

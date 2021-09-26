import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_model.dart';
import 'package:kapiot/logic/shared/shared_state.dart';

class PostTripSummaryView extends HookConsumerWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(postTripSummaryViewModel);
    final transaction = ref.watch(transactionProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    });

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CES: ${transaction.points}'),
                Text('Origin: ${transaction.startLocation?.address}'),
                Text('Destination: ${transaction.endLocation?.address}'),
                Text('Start time: ${transaction.startTime}'),
                Text('End time: ${transaction.endTime}'),
                Text(
                  'Duration: ${transaction.endTime!.difference(transaction.startTime!)}',
                ),
                Text('Distance: ${transaction.distance} km'),
                Text('Driver: ${transaction.driver!.user.displayName}'),
                Text(
                  'Riders: ${transaction.riders!.map((rc) => rc.user.displayName)}',
                ),
                ElevatedButton(
                  onPressed: model.resetToHomeView,
                  child: const Text('Back to HomeView'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

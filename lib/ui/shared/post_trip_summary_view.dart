import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_model.dart';

class PostTripSummaryView extends HookConsumerWidget {
  const PostTripSummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final model = ref.watch(postTripSummaryViewModel);
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
                const Text('CES: 69'),
                const Text('Origin: Eskina Japan'),
                const Text('Destination: Eskina Singapore'),
                const Text('Duration: 69mins'),
                const Text('Distance: 69km'),
                const Text('Driver: '),
                const Text('Riders: '),
                ElevatedButton(
                  onPressed: () {},
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

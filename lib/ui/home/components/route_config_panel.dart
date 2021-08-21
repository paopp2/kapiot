import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

class RouteConfigPanel extends HookConsumerWidget {
  const RouteConfigPanel({
    Key? key,
    required this.constraints,
    required this.model,
  }) : super(key: key);

  final BoxConstraints constraints;
  final HomeViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRider = ref.watch(isRiderSelectedProvider).state;
    final riderCount = ref.watch(riderCountProvider).state;
    final dateTime = ref.watch(dateTimeProvider).state;

    return Container(
      height: constraints.maxHeight * 0.43,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: const Text("Driver"),
                  selected: !isRider,
                  onSelected: model.toggleIsRider,
                ),
                ChoiceChip(
                  label: const Text("Rider"),
                  selected: isRider,
                  onSelected: model.toggleIsRider,
                ),
              ],
            ),
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: "Start location"),
            ),
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: "End location"),
            ),
            TextButton(
              child: Text("$dateTime"),
              onPressed: () => model.getDateTime(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: model.decRiderCount,
                  child: const Icon(Icons.remove),
                ),
                Text("$riderCount"),
                OutlinedButton(
                  onPressed: model.incRiderCount,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text("Go to Lake"),
              onPressed: model.mapController.gotoLake,
            ),
          ],
        ),
      ),
    );
  }
}

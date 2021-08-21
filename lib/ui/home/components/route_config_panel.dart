import 'package:flutter/material.dart';
import 'package:kapiot/logic/home/home_view_model.dart';

class RouteConfigPanel extends StatelessWidget {
  const RouteConfigPanel({
    Key? key,
    required this.constraints,
    required this.model,
    required this.isRider,
    required this.riderCount,
    required this.dateTime,
  }) : super(key: key);

  final BoxConstraints constraints;
  final HomeViewModel model;
  final bool isRider;
  final int riderCount;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
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

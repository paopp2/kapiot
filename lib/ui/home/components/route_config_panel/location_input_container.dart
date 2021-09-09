import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/logic/shared/map_controller.dart';

class LocationInputContainer extends HookConsumerWidget {
  const LocationInputContainer({
    Key? key,
    required this.constraints,
    required this.isStart,
    required this.model,
  }) : super(key: key);

  final BoxConstraints constraints;
  final bool isStart;
  final HomeViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAddress = ref.watch(startLocProvider).state?.address;
    final endAddress = ref.watch(endLocProvider).state?.address;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.025,
        vertical: constraints.maxHeight * 0.015,
      ),
      child: GestureDetector(
        onTap: () => model.openPlacePickerView(isForStartLoc: isStart),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: constraints.maxWidth * 0.03),
              child: Icon(
                isStart
                    ? CupertinoIcons.smallcircle_circle
                    : CupertinoIcons.location,
                color: Colors.blue,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  isStart
                      ? (startAddress ?? 'Start Location')
                      : (endAddress ?? 'End Location'),
                  style: TextStyle(
                    fontSize: 17,
                    color: isStart
                        ? ((startAddress != null) ? Colors.black : Colors.grey)
                        : ((endAddress != null) ? Colors.black : Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

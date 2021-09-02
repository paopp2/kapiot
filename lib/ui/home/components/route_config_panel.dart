import 'package:flutter/cupertino.dart';
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
    final isRider = ref.watch(isRiderProvider).state;
    final riderCount = ref.watch(riderCountProvider).state;
    final dateTime = ref.watch(dateTimeProvider).state;
    final isStartLocFocused = ref.watch(isStartLocFocusedProvider).state;
    final isEndLocFocused = ref.watch(isEndLocFocusedProvider).state;
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;

    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFFE7DFE0)),
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                  margin: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.02),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.tecStartLoc,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              CupertinoIcons.smallcircle_circle,
                            ),
                            hintText: "Start location",
                            border: InputBorder.none),
                        onChanged: model.updateSuggestions,
                        onTap: () => model.expandSuggestions(forStartLoc: true),
                      ),
                      Visibility(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.25,
                          child: ListView.builder(
                            itemCount: placeSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = placeSuggestions[index] ?? "";
                              return ListTile(
                                title: Text(suggestion),
                                onTap: () => model.pickSuggestion(
                                  pickedSuggestion: suggestion,
                                  forStartLoc: true,
                                ),
                              );
                            },
                          ),
                        ),
                        visible: isStartLocFocused,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                        height: 0.05,
                      ),
                      TextField(
                        controller: model.tecEndLoc,
                        onChanged: model.updateSuggestions,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.location),
                            hintText: "End location",
                            border: InputBorder.none),
                        onTap: () =>
                            model.expandSuggestions(forStartLoc: false),
                      ),
                      Visibility(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.25,
                          child: ListView.builder(
                            itemCount: placeSuggestions.length,
                            itemBuilder: (context, index) {
                              final suggestion = placeSuggestions[index] ?? "";
                              return ListTile(
                                title: Text(suggestion),
                                onTap: () => model.pickSuggestion(
                                  pickedSuggestion: suggestion,
                                  forStartLoc: false,
                                ),
                              );
                            },
                          ),
                        ),
                        visible: isEndLocFocused,
                      ),
                    ],
                  ),
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
                  child: const Text("Next"),
                  onPressed: model.pushRouteConfig,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

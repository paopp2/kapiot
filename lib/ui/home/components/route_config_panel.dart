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
    final isStartLocFocused = ref.watch(isStartLocFocusedProvider).state;
    final isEndLocFocused = ref.watch(isEndLocFocusedProvider).state;
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;

    return Container(
      height: constraints.maxHeight * 0.43,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
              TextField(
                controller: model.tecStartLoc,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: "Start location"),
                onChanged: model.getAutoComplete,
                onTap: () => model.showSuggestions(forStartLoc: true),
              ),
              Visibility(
                child: SizedBox(
                  height: constraints.maxHeight * 0.25,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: placeSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(placeSuggestions[index]),
                          onTap: () => model.pickSuggestion(
                            index: index,
                            forStartLoc: true,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                visible: isStartLocFocused,
              ),
              TextField(
                controller: model.tecEndLoc,
                onChanged: model.getAutoComplete,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: "End location"),
                onTap: () => model.showSuggestions(forStartLoc: false),
              ),
              Visibility(
                child: SizedBox(
                  height: constraints.maxHeight * 0.25,
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: placeSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(placeSuggestions[index]),
                          onTap: () => model.pickSuggestion(
                            index: index,
                            forStartLoc: false,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                visible: isEndLocFocused,
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

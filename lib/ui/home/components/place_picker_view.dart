import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/home/place_picker_view_model.dart';

class PlacePickerView extends HookConsumerWidget {
  const PlacePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placePickerViewModel);
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;
    final isForStartLoc = ref.watch(isForStartLocProvider).state;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: AppRouter.instance.popView,
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Colors.blue,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFFE7DFE0)),
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    margin:
                        EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
                    child: Column(
                      children: [
                        TextField(
                          controller: model.tecStartLoc,
                          textAlign: TextAlign.start,
                          onTap: () => model.expandSuggestions(
                            isForStartLoc: true,
                          ),
                          onChanged: model.updateSuggestions,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                CupertinoIcons.smallcircle_circle,
                              ),
                              hintText: "Start location",
                              border: InputBorder.none),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                          height: 0.05,
                        ),
                        TextField(
                          controller: model.tecEndLoc,
                          textAlign: TextAlign.start,
                          onTap: () => model.expandSuggestions(
                            isForStartLoc: false,
                          ),
                          onChanged: model.updateSuggestions,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.location),
                            hintText: "End location",
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: placeSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = placeSuggestions[index] ?? "";
                        return Column(
                          children: [
                            ListTile(
                              dense: true,
                              title: Text(
                                suggestion,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: const Text(
                                "Cebu, Philippines",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13),
                              ),
                              onTap: () => model.pickSuggestion(
                                pickedSuggestion: suggestion,
                                forStartLoc: isForStartLoc,
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                              height: 0.05,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

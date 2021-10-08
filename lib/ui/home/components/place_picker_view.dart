import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/home/place_picker_view_model.dart';

class PlacePickerView extends HookConsumerWidget {
  const PlacePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placePickerViewModel);
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;
    final isForStartLoc = ref.watch(isForStartLocProvider).state;
    final currentUserInfo = ref.watch(currentUserInfoProvider).data?.value;
    final savedLocations = currentUserInfo?.savedLocations;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFFE7DFE0),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    margin:
                        EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
                    child: Column(
                      children: [
                        TextField(
                          controller: model.tecStartLoc,
                          focusNode: model.startLocFocusNode,
                          textAlign: TextAlign.start,
                          onTap: () => model.editPlaceAddress(
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
                          focusNode: model.endLocFocusNode,
                          textAlign: TextAlign.start,
                          onTap: () => model.editPlaceAddress(
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
                  Container(
                    margin: const EdgeInsets.only(top: 2.5),
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05,
                      vertical: 5,
                    ),
                    height: 80,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: const Color(0XFFE7DFE0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Saved Places'),
                            GestureDetector(
                              onTap: model.gotoPlaceManagerView,
                              child: Row(
                                children: const [
                                  Text('Manage'),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: savedLocations!.length,
                            itemBuilder: (context, index) {
                              final location = savedLocations[index];
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: ActionChip(
                                  onPressed: () => model.pickSavedLocation(
                                    location,
                                  ),
                                  label: Text(location.keys.first),
                                  backgroundColor: Colors.white,
                                  shape: const StadiumBorder(
                                    side: BorderSide(),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: placeSuggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = placeSuggestions[index] ?? "";
                        final suggestionSplit = model.splitAddress(suggestion);
                        return Column(
                          children: [
                            ListTile(
                              dense: true,
                              title: Text(
                                suggestionSplit.first,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                suggestionSplit.last,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13),
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

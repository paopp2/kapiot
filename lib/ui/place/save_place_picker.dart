import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/place/place_manager_view_model.dart';
import 'package:kapiot/logic/place/place_suggester.dart';
import 'package:kapiot/logic/shared/extensions.dart';

class SavePlacePicker extends HookConsumerWidget {
  const SavePlacePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placeManagerViewModel);
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;

    useEffect(() {
      model.saveLocFocusNode.requestFocus();
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
                  margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
                  child: TextField(
                    controller: model.tecSaveLoc,
                    focusNode: model.saveLocFocusNode,
                    onTap: model.editPlaceAddress,
                    decoration: const InputDecoration(
                      hintText: "Enter Address",
                      border: InputBorder.none,
                    ),
                    onChanged: model.placeSuggester.updateSuggestions,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: placeSuggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = placeSuggestions[index] ?? "";
                      final suggestionSplit = suggestion.splitAddress();
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
    });
  }
}

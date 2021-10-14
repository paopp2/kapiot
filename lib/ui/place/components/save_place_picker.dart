import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/place/place_manager_view_model.dart';
import 'package:kapiot/ui/place/base_place_picker.dart';

class SavePlacePicker extends HookConsumerWidget {
  const SavePlacePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placeManagerViewModel);

    useEffect(() {
      model.saveLocFocusNode.requestFocus();
    }, []);

    return BasePlacePicker(
      onPlaceSuggestionTap: (suggestion) => model.pickSuggestion(
        pickedSuggestion: suggestion,
      ),
      header: (context, constraints) {
        return [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0XFFE7DFE0),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05,
            ),
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
        ];
      },
    );
  }
}

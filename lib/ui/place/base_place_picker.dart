import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/shared/extensions.dart';

class BasePlacePicker extends StatelessWidget {
  const BasePlacePicker({
    Key? key,
    required this.header,
    required this.placeSuggestions,
    required this.onPlaceSuggestionTap,
  }) : super(key: key);

  final List<Widget> Function(
    BoxConstraints,
  ) header;
  final List<String?> placeSuggestions;
  final void Function()? onPlaceSuggestionTap;
  late BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
                children: header
                  ..add(Expanded(
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
                              onTap: onPlaceSuggestionTap,
                              // onTap: () => model.pickSuggestion(
                              //   pickedSuggestion: suggestion,
                              // ),
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
                  )),

                // [
                //   // Container(
                //   //   decoration: BoxDecoration(
                //   //     borderRadius: BorderRadius.circular(20),
                //   //     color: const Color(0XFFE7DFE0),
                //   //   ),
                //   //   padding: EdgeInsets.symmetric(
                //   //     horizontal: constraints.maxWidth * 0.05,
                //   //   ),
                //   //   margin:
                //   //       EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
                //   //   child: TextField(
                //   //     controller: model.tecSaveLoc,
                //   //     focusNode: model.saveLocFocusNode,
                //   //     onTap: model.editPlaceAddress,
                //   //     decoration: const InputDecoration(
                //   //       hintText: "Enter Address",
                //   //       border: InputBorder.none,
                //   //     ),
                //   //     onChanged: model.placeSuggester.updateSuggestions,
                //   //   ),
                //   // ),
                //   ,
                // ],
              ),
            ),
          ),
        );
      },
    );
  }
}

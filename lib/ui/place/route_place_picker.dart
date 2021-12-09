import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/home/home_view_state.dart';
import 'package:kapiot/logic/place/route_place_picker_model.dart';
import 'package:kapiot/ui/place/components/base_place_picker.dart';

class RoutePlacePicker extends HookConsumerWidget {
  const RoutePlacePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(routePlacePickerModel);
    final isForStartLoc = ref.watch(isForStartLocProvider);
    final currentUserInfo = ref.watch(currentUserInfoProvider).asData?.value;
    final savedLocations = currentUserInfo?.savedLocations;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return BasePlacePicker(
      onPlaceSuggestionTap: (suggestion) {
        model.pickSuggestion(
          pickedSuggestion: suggestion,
          forStartLoc: isForStartLoc,
        );
      },
      header: (context, constraints) {
        return [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xffF2F3F8),
                width: 2,
              ),
              color: const Color(0xffF8F9FD),
            ),
            margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
            child: Column(
              children: [
                TextField(
                  controller: model.tecStartLoc,
                  focusNode: model.startLocFocusNode,
                  textAlign: TextAlign.start,
                  onTap: () => model.editPlaceAddress(
                    isForStartLoc: true,
                  ),
                  onChanged: model.placeSuggester.updateSuggestions,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    color: const Color(0xff333333),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.smallcircle_fill_circle_fill,
                      color: Color(0xFF716bfd),
                      size: 27,
                    ),
                    hintText: "Start Location",
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: const Color(0xffaaaaaa),
                    ),
                    border: InputBorder.none,
                  ),
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
                  onChanged: model.placeSuggester.updateSuggestions,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    color: const Color(0xff333333),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      CupertinoIcons.location,
                      color: Color(0xFF716bfd),
                      size: 27,
                    ),
                    hintText: "End Location",
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: const Color(0xffaaaaaa),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2.5),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            height: 80,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xffF2F3F8),
                width: 2,
              ),
              color: const Color(0xffF8F9FD),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saved Places',
                        style: GoogleFonts.montserrat(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: model.gotoPlaceManagerView,
                        child: Row(
                          children: [
                            Text(
                              'Manage',
                              style: GoogleFonts.montserrat(fontSize: 14),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                savedLocations?.isEmpty ?? true
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05,
                        ),
                        child: Text(
                          'Book easier! Trip configuration is faster when places you usually visit are saved.',
                          style: GoogleFonts.montserrat(fontSize: 14),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: savedLocations!.length,
                          itemBuilder: (context, index) {
                            final sortedKeys = savedLocations.keys.toList()
                              ..sort();
                            final locLabel = sortedKeys[index];
                            final location = savedLocations[locLabel];
                            return ActionChip(
                              onPressed: () => model.pickSavedLocation(
                                location!,
                              ),
                              label: Text(
                                locLabel,
                                style: GoogleFonts.montserrat(fontSize: 14),
                              ),
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              backgroundColor: Colors.white,
                              shape: const StadiumBorder(
                                side: BorderSide(color: Color(0xffF2F3F8)),
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ];
      },
    );
  }
}

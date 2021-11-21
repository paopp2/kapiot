import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/place/place_manager_view_model.dart';

class PlaceManagerView extends HookConsumerWidget {
  const PlaceManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placeManagerViewModel);
    final currentUserInfo = ref.watch(currentUserInfoProvider).asData?.value;
    final savedLocations = currentUserInfo?.savedLocations;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: const Color(0xffF8F9FD),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: AppRouter.instance.popView,
                icon: const Icon(
                  CupertinoIcons.arrow_left,
                  color: Color(0xFF5F45A4),
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffF2F3F8),
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.025,
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  child: Text(
                    'Saved Places',
                    style: GoogleFonts.poppins(
                      color: const Color(0xff333333),
                      fontSize: 14,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: savedLocations!.length + 1,
                      itemBuilder: (context, index) {
                        final lastIndex = savedLocations.length;
                        final isLastItem = (index == lastIndex);
                        if (isLastItem) {
                          return SizedBox(
                            height: 70,
                            child: Center(
                              child: ListTile(
                                onTap: model.getLocationToSave,
                                leading: const Icon(
                                  Icons.add,
                                  color: Color(0xFF5F45A4),
                                ),
                                title: Text(
                                  'Add New',
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xff333333),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          final sortedKeys = savedLocations.keys.toList()
                            ..sort();
                          final locLabel = sortedKeys[index];
                          final location = savedLocations[locLabel];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 70,
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.bookmark,
                                      color: Color(0xFF5F45A4),
                                    ),
                                    title: Text(
                                      locLabel,
                                      style: GoogleFonts.montserrat(
                                        color: const Color(0xff333333),
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      location?.address! ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                        color: const Color(0xff333333),
                                        fontSize: 13,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () => model.editSavedLocation(
                                        locLabel,
                                        location,
                                      ),
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Color(0xFF5F45A4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

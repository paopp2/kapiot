import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/place/place_manager_view_model.dart';
import 'package:kapiot/logic/place/place_manager_view_state.dart';
import 'package:kapiot/logic/shared/extensions.dart';

class SavePlaceView extends HookConsumerWidget {
  const SavePlaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placeManagerViewModel);
    final initialLabel = ModalRoute.of(context)?.settings.arguments as String?;
    final tecLabel = useTextEditingController(text: initialLabel);
    final locationToSave = ref.watch(locationToSaveProvider).state;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: constraints.maxWidth * 0.05,
                        ),
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: GoogleFonts.poppins(
                                color: const Color(0xff333333),
                                fontSize: 14,
                                letterSpacing: 1.5,
                              ),
                            ),
                            TextField(
                              controller: tecLabel,
                              style: GoogleFonts.montserrat(
                                fontSize: 17,
                                color: const Color(0xff333333),
                              ),
                              onTap: tecLabel.selectText,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'e.g. Gym / Airport',
                                hintStyle: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  color: const Color(0xffaaaaaa),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: model.editLocationToSave,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: constraints.maxWidth * 0.05,
                          ),
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff333333),
                                  fontSize: 14,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              ListTile(
                                title: Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: Text(
                                    locationToSave?.address ?? 'No location',
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      color: const Color(0xff333333),
                                    ),
                                  ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                minLeadingWidth: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                  child: ElevatedButton(
                    onPressed: () => model.saveLocation(label: tecLabel.text),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF5F45A4),
                      elevation: 0,
                      fixedSize: Size(constraints.maxWidth * 0.9, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 17,
                        letterSpacing: 1.5,
                      ),
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

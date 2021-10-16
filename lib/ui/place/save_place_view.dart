import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
                            const Text('Name'),
                            TextField(
                              controller: tecLabel,
                              onTap: tecLabel.selectText,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'e.g. Gym / Airport',
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
                              const Text('Address'),
                              ListTile(
                                title: Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: Text(
                                    locationToSave?.address ?? 'No location',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                // dense: true,
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
                  color: const Color(0xffcccccc),
                  width: constraints.maxWidth * 0.9,
                  child: TextButton(
                    onPressed: () => model.saveLocation(label: tecLabel.text),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/place/place_manager_view_model.dart';

class PlaceManagerView extends HookConsumerWidget {
  const PlaceManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(placeManagerViewModel);
    final currentUserInfo = ref.watch(currentUserInfoProvider).data?.value;
    final savedLocations = currentUserInfo?.savedLocations;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: const Color(0xffeeeeee),
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
            body: Container(
              color: const Color(0xffeeeeee),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.025,
                      horizontal: constraints.maxWidth * 0.05,
                    ),
                    child: const Text('Saved Places'),
                  ),
                  Container(
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
                            height: 80,
                            child: Center(
                              child: ListTile(
                                onTap: model.getLocationToSave,
                                leading: const Icon(Icons.add),
                                title: const Text('Add New'),
                              ),
                            ),
                          );
                        } else {
                          final sortedKeys = savedLocations.keys.toList()
                            ..sort();
                          final locLabel = sortedKeys[index];
                          final location = savedLocations[locLabel];
                          return Column(
                            children: [
                              SizedBox(
                                height: 80,
                                child: Center(
                                  child: ListTile(
                                    leading: const Icon(Icons.bookmark),
                                    title: Text(locLabel),
                                    subtitle: Text(
                                      location?.address! ?? '',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: IconButton(
                                      onPressed: () => model.editSavedLocation(
                                        locLabel,
                                        location,
                                      ),
                                      icon: const Icon(Icons.edit),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.025,
                      horizontal: constraints.maxWidth * 0.05,
                    ),
                    child: const Text('Recently Used'),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.access_time_rounded),
                              title: Text('University of San Carlos'),
                              subtitle: Text(
                                'Sunlight Drive, Sunny Hills Subdivision, Talamban, Cebu City, Philippines',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Icon(Icons.bookmark_outline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kapiot/constants/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/extensions.dart';
import 'package:kapiot/logic/user_info/edit_user_info/init_user_info_view_model.dart';
import 'package:kapiot/logic/user_info/init_user_info/init_user_info_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class InitUserInfoView extends HookConsumerWidget {
  const InitUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(initUserInfoViewModel);
    final pageIndex = ref.watch(pageIndexProvider).state;
    final selectedUserType = ref.watch(userTypeProvider).state;
    final placeSuggestions = ref.watch(placeSuggestionsProvider).state;
    final isForHomeLoc = ref.watch(isForHomeLocProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return LayoutBuilder(builder: (context, constraints) {
      final List<Widget> pageList = [
        const SizedBox(),
        Text(
          'To which association do you belong?',
          style: Styles.middleSizeText,
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Wrap(
                spacing: constraints.maxWidth * 0.025,
                children: [
                  ChoiceChip(
                    onSelected: (_) => model.setUserType(UserType.student),
                    selected: selectedUserType == UserType.student,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    label: const Text('Student'),
                  ),
                  ChoiceChip(
                    onSelected: (_) => model.setUserType(UserType.faculty),
                    selected: selectedUserType == UserType.faculty,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    label: const Text('Faculty'),
                  ),
                  ChoiceChip(
                    onSelected: (_) => model.setUserType(UserType.staff),
                    selected: selectedUserType == UserType.staff,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    label: const Text('Staff'),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: constraints.maxHeight * 0.5),
                child: TextButton(
                  onPressed: model.goToNextStep,
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.05,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'If ganahan ka, pwede ka mosave og location bookmarks daan for later use.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  TextField(
                    controller: model.tecHomeLoc,
                    focusNode: model.homeLocFocusNode,
                    textAlign: TextAlign.start,
                    onTap: () => model.editPlaceAddress(
                      isForStartLoc: true,
                    ),
                    onChanged: model.placeSuggester.updateSuggestions,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        hintText: "Home",
                        border: InputBorder.none),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                    height: 0.05,
                  ),
                  TextField(
                    controller: model.tecSchoolLoc,
                    focusNode: model.schoolLocFocusNode,
                    textAlign: TextAlign.start,
                    onTap: () => model.editPlaceAddress(
                      isForStartLoc: false,
                    ),
                    onChanged: model.placeSuggester.updateSuggestions,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(CupertinoIcons.building_2_fill),
                      hintText: (selectedUserType == UserType.student)
                          ? "School"
                          : "Work",
                      border: InputBorder.none,
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
                                forStartLoc: isForHomeLoc,
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
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: model.updateUserInfo,
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              switchInCurve: Curves.easeInBack,
              switchOutCurve: Curves.easeInBack,
              child: pageList[pageIndex],
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kapiot/constants/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/user_info/init_user_info/init_user_info_view_state.dart';
import 'package:kapiot/logic/user_info/init_user_info/init_user_info_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class InitUserInfoView extends HookConsumerWidget {
  const InitUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(initUserInfoViewModel);
    final pageIndex = ref.watch(pageIndexProvider).state;
    final selectedUserType = ref.watch(userTypeProvider).state;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
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
                vertical: constraints.maxHeight * 0.05,
                horizontal: constraints.maxWidth * 0.075,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Saved Places',
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.025,
                        ),
                        const Text(
                          'Saved Places helps you to easily set ride configurations.',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0XFFE7DFE0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.05,
                          ),
                          margin: EdgeInsets.only(
                            bottom: constraints.maxHeight * 0.01,
                          ),
                          child: TextField(
                            controller: model.tecHomeLoc,
                            focusNode: model.homeLocFocusNode,
                            textAlign: TextAlign.start,
                            onTap: () => model.editPlaceAddress(
                              isForHomeLoc: true,
                            ),
                            onChanged: model.placeSuggester.updateSuggestions,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.home),
                              hintText: "Home",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                          height: 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0XFFE7DFE0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * 0.05,
                          ),
                          margin: EdgeInsets.only(
                            bottom: constraints.maxHeight * 0.01,
                          ),
                          child: TextField(
                            controller: model.tecSchoolLoc,
                            focusNode: model.schoolLocFocusNode,
                            textAlign: TextAlign.start,
                            onTap: () => model.editPlaceAddress(
                              isForHomeLoc: false,
                            ),
                            onChanged: model.placeSuggester.updateSuggestions,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                CupertinoIcons.building_2_fill,
                              ),
                              hintText: (selectedUserType == UserType.student)
                                  ? "School"
                                  : "Work",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: constraints.maxWidth * 0.75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xffdbb3d4),
                          ),
                          child: TextButton(
                            onPressed: model.updateUserInfo,
                            child: const Text(
                              'Save Configuration',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: model.updateUserInfo,
                          child: const Text(
                            'Set Up Later',
                            style: TextStyle(color: Color(0xffdbb3d4)),
                          ),
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
        },
      ),
    );
  }
}

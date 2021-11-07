import 'package:entry/entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapiot/constants/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/core/core_providers.dart';
import 'package:kapiot/logic/shared/extensions.dart';
import 'package:kapiot/logic/user_info/init_user_info/init_user_info_view_state.dart';
import 'package:kapiot/logic/user_info/init_user_info/init_user_info_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/ui/shared/location_input_container.dart';

class InitUserInfoView extends HookConsumerWidget {
  const InitUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(initUserInfoViewModel);
    final pageIndex = ref.watch(pageIndexProvider).state;
    final selectedUserType = ref.watch(userTypeProvider).state;
    final homeFieldText = ref.watch(homeFieldTextProvider).state;
    final nonHomeFieldText = ref.watch(nonHomeFieldTextProvider).state;
    final currentUser = ref.watch(currentUserProvider)!;

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final List<Widget> pageList = [
              Builder(builder: (_) {
                model.goToNextStep(after: Duration.zero);
                return const SizedBox();
              }),
              Builder(builder: (_) {
                model.goToNextStep(after: const Duration(seconds: 4));
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Entry(
                      yOffset: 30,
                      delay: const Duration(seconds: 2),
                      duration: const Duration(seconds: 1),
                      child: Text(
                        'Hello ${currentUser.displayName!.firstName}',
                        style: Styles.priLargeSizedText,
                      ),
                    ),
                    Entry.opacity(
                      delay: const Duration(milliseconds: 2250),
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        'Just a couple more things about yourself',
                        style: Styles.priMiddleSizedText,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Choose your role at USC',
                              style: Styles.priMiddleSizedText,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.05,
                            ),
                            Wrap(
                              spacing: constraints.maxWidth * 0.025,
                              children: [
                                ChoiceChip(
                                  onSelected: (_) =>
                                      model.setUserType(UserType.student),
                                  selected:
                                      selectedUserType == UserType.student,
                                  selectedColor: const Color(0xFFBFB4DA),
                                  labelPadding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                    horizontal: 15,
                                  ),
                                  label: Text(
                                    'Student',
                                    style: Styles.secMiddleSizedText,
                                  ),
                                ),
                                ChoiceChip(
                                  onSelected: (_) =>
                                      model.setUserType(UserType.faculty),
                                  selected:
                                      selectedUserType == UserType.faculty,
                                  selectedColor: const Color(0xFFBFB4DA),
                                  labelPadding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                    horizontal: 15,
                                  ),
                                  label: Text(
                                    'Faculty',
                                    style: Styles.secMiddleSizedText,
                                  ),
                                ),
                                ChoiceChip(
                                  onSelected: (_) =>
                                      model.setUserType(UserType.staff),
                                  selected: selectedUserType == UserType.staff,
                                  selectedColor: const Color(0xFFBFB4DA),
                                  labelPadding: const EdgeInsets.symmetric(
                                    vertical: 7,
                                    horizontal: 15,
                                  ),
                                  label: Text(
                                    'Staff',
                                    style: Styles.secMiddleSizedText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                      child: ElevatedButton(
                        onPressed: model.goToNextStep,
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF5F45A4),
                          elevation: 0,
                          fixedSize: Size(constraints.maxWidth * 0.725, 50),
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
              ),
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 275,
                            margin: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.05,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Saved Places',
                                  style: Styles.priLargeSizedText,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Saved Places help you to easily set ride configurations.',
                                  textAlign: TextAlign.center,
                                  style: Styles.secSmallSizedText,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xffF2F3F8),
                                width: 2,
                              ),
                              color: const Color(0xffF8F9FD),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.05,
                            ),
                            margin: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.01,
                            ),
                            child: LocationInputContainer(
                              constraints: constraints,
                              onPressed: () => model.openSavePlacePicker(
                                isForHome: true,
                              ),
                              leadingIcon: Icons.home,
                              text: homeFieldText,
                              hint: 'Home',
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xffF2F3F8),
                                width: 2,
                              ),
                              color: const Color(0xffF8F9FD),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.05,
                            ),
                            margin: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.01,
                            ),
                            child: LocationInputContainer(
                              constraints: constraints,
                              onPressed: () => model.openSavePlacePicker(
                                isForHome: false,
                              ),
                              leadingIcon: Icons.work,
                              text: nonHomeFieldText,
                              hint: (selectedUserType == UserType.student)
                                  ? 'School'
                                  : 'Work',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                      child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: model.goToNextStep,
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFF5F45A4),
                              elevation: 0,
                              fixedSize: Size(constraints.maxWidth * 0.725, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Save Configuration',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 17,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => model
                              ..goToNextStep()
                              ..skipSavingLocations(),
                            child: Text(
                              'Set Up Later',
                              style: GoogleFonts.montserrat(
                                color: const Color(0xFF5F45A4),
                                fontSize: 17,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Builder(builder: (context) {
                Future.delayed(
                  const Duration(seconds: 2),
                  model.updateUserInfo,
                );
                return const Center(
                  child: Text('Welcome to Kapiot'),
                );
              }),
              const SizedBox(),
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
      ),
    );
  }
}

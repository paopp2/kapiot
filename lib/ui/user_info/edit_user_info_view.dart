import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kapiot/constants/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/user_info/edit_user_info_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

final indexProvider = StateProvider((ref) => 0);

class EditUserInfoView extends HookConsumerWidget {
  const EditUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(indexProvider).state;
    int selectedIndex = 0;
    final model = ref.watch(editUserInfoViewModel);
    useEffect(() {
      Future.delayed(Duration.zero, () => ref.read(indexProvider).state++);
      Future.delayed(
        const Duration(seconds: 3),
        () => ref.read(indexProvider).state++,
      );
    }, []);

    return LayoutBuilder(builder: (context, constraints) {
      final List<Widget> pageList = [
        const SizedBox(),
        Text(
          'To which association do you belong?',
          key: ValueKey('userTypeQuestionPrompt'),
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
                    selected: selectedIndex == 0,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    label: const Text('Student'),
                  ),
                  ChoiceChip(
                    onSelected: (_) => model.setUserType(UserType.faculty),
                    selected: selectedIndex == 1,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 15,
                    ),
                    label: const Text('Faculty'),
                  ),
                  ChoiceChip(
                    onSelected: (_) => model.setUserType(UserType.staff),
                    selected: selectedIndex == 2,
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
                  onPressed: () => ref.read(indexProvider).state++,
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
                    height: constraints.maxHeight * 0.1,
                  ),
                  const Text('home'),
                  const TextField()
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Skip'),
                ),
              ),
            ],
          ),
        ),
      ];
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: Curves.easeInBack,
            switchOutCurve: Curves.easeInBack,
            child: pageList[index],
          ),
        ),
      );
    });
  }
}

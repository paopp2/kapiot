import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final indexProvider = StateProvider((ref) => 0);

class EditUserInfoView extends HookConsumerWidget {
  const EditUserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(indexProvider).state;
    int selectedIndex = 0;

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
        const Text(
          'Before anything else, unsa ka?',
          key: ValueKey('Welcome message'),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: constraints.maxWidth * 0.025,
              children: [
                ChoiceChip(
                  selected: selectedIndex == 0,
                  labelPadding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 15,
                  ),
                  label: const Text('Student'),
                ),
                ChoiceChip(
                  selected: selectedIndex == 1,
                  labelPadding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 15,
                  ),
                  label: const Text('Faculty'),
                ),
                ChoiceChip(
                  selected: selectedIndex == 2,
                  labelPadding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 15,
                  ),
                  label: const Text('Staff'),
                ),
              ],
            ),
            TextButton(
              onPressed: () => ref.read(indexProvider).state++,
              child: const Text('Submit'),
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

// class EditUserInfoView extends StatefulWidget {
//   const EditUserInfoView({Key? key}) : super(key: key);

//   @override
//   State<EditUserInfoView> createState() => _EditUserInfoViewState();
// }

// class _EditUserInfoViewState extends State<EditUserInfoView> {
//   bool isQuestionVisible = false;
//   bool isChoiceVisible = false;
//   bool optionalView = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         isQuestionVisible = true;
//       });
//     });

//     Future.delayed(const Duration(seconds: 4), () {
//       setState(() {
//         isChoiceVisible = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return Scaffold(
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   !optionalView
//                       ? Stack(
//                           children: [
//                             Entry.opacity(
//                               duration: const Duration(milliseconds: 750),
//                               child: AnimatedOpacity(
//                                 opacity: !isQuestionVisible ? 1 : 0,
//                                 duration: const Duration(milliseconds: 750),
//                                 child: const Center(
//                                   child: Text('Before anything else, unsa ka?'),
//                                 ),
//                               ),
//                             ),
//                             AnimatedOpacity(
//                               opacity: isChoiceVisible ? 1 : 0,
//                               duration: const Duration(milliseconds: 750),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     Wrap(
//                                       spacing: constraints.maxWidth * 0.025,
//                                       children: const [
//                                         Chip(
//                                           labelPadding: EdgeInsets.symmetric(
//                                             vertical: 7,
//                                             horizontal: 15,
//                                           ),
//                                           label: Text('Student'),
//                                         ),
//                                         Chip(
//                                           labelPadding: EdgeInsets.symmetric(
//                                             vertical: 7,
//                                             horizontal: 15,
//                                           ),
//                                           label: Text('Faculty'),
//                                         ),
//                                         Chip(
//                                           labelPadding: EdgeInsets.symmetric(
//                                             vertical: 7,
//                                             horizontal: 15,
//                                           ),
//                                           label: Text('Staff'),
//                                         ),
//                                       ],
//                                     ),
//                                     TextButton(
//                                       onPressed: () {
//                                         print('proceed to next view');
//                                         setState(() {
//                                           optionalView = true;
//                                         });
//                                       },
//                                       child: const Text('Submit'),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container(
//                           height: constraints.maxHeight,
//                           width: constraints.maxWidth,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: constraints.maxWidth * 0.05,
//                           ),
//                           child: Stack(
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Text(
//                                     'If ganahan ka, pwede ka mosave og location bookmarks daan for later use.',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   SizedBox(
//                                     height: constraints.maxHeight * 0.1,
//                                   ),
//                                   const Text('home'),
//                                   const TextField()
//                                 ],
//                               ),
//                               Align(
//                                 alignment: Alignment.bottomRight,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     print('Skip this part');
//                                   },
//                                   child: const Text('Skip'),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

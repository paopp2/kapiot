import 'package:entry/entry.dart';
import 'package:flutter/material.dart';

class EditUserInfoView extends StatefulWidget {
  const EditUserInfoView({Key? key}) : super(key: key);

  @override
  State<EditUserInfoView> createState() => _EditUserInfoViewState();
}

class _EditUserInfoViewState extends State<EditUserInfoView> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          isVisible =
              true; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    !isVisible
                        ? AnimatedOpacity(
                            opacity: !isVisible ? 1 : 0,
                            duration: Duration(seconds: 1),
                            child: Center(
                              child: Text('Before anythuings els, unsa ka?'),
                            ),
                          )
                        : AnimatedOpacity(
                            opacity: isVisible ? 1 : 0,
                            duration: Duration(seconds: 1),
                            child: Center(
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: constraints.maxWidth * 0.025,
                                    children: const [
                                      Chip(
                                        labelPadding: EdgeInsets.symmetric(
                                          vertical: 7,
                                          horizontal: 15,
                                        ),
                                        label: Text('Student'),
                                      ),
                                      Chip(
                                        labelPadding: EdgeInsets.symmetric(
                                          vertical: 7,
                                          horizontal: 15,
                                        ),
                                        label: Text('Faculty'),
                                      ),
                                      Chip(
                                        labelPadding: EdgeInsets.symmetric(
                                          vertical: 7,
                                          horizontal: 15,
                                        ),
                                        label: Text('Staff'),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text('Submit'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

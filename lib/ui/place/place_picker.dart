import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/place/place_manager_view_model.dart';

class BasePlacePicker extends StatelessWidget {
  const BasePlacePicker({
    Key? key,
    required this.content,
  }) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: content,
        ),
      ),
    );
  }
}

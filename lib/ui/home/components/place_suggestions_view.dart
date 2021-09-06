import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';

class PlaceSuggestionsView extends StatelessWidget {
  const PlaceSuggestionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0XFFE7DFE0)),
                      padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.05),
                      child: Column(
                        children: const [
                          TextField(
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  CupertinoIcons.smallcircle_circle,
                                ),
                                hintText: "Start location",
                                border: InputBorder.none),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 1,
                            height: 0.05,
                          ),
                          TextField(
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.location),
                                hintText: "End location",
                                border: InputBorder.none),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

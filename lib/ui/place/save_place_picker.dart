import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';

class SavePlacePicker extends StatelessWidget {
  const SavePlacePicker({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0XFFE7DFE0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                  margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Address",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: const [
                          ListTile(
                            dense: true,
                            title: Text(
                              'USC Talamban',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              'Talamban, Cebu City',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Divider(
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
          ),
        ),
      );
    });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';

class SavePlaceView extends StatelessWidget {
  const SavePlaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: constraints.maxWidth * 0.05,
                        ),
                        height: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Name'),
                            TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'e.g. Gym / Airport',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          print('Go to place picker');
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 5,
                            bottom: 5,
                            left: constraints.maxWidth * 0.05,
                          ),
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Address'),
                              ListTile(
                                title: Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: const Text(
                                    'Ayala Center Cebu Cardinal Rosales Ave. Entrance, Cebu City',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                // dense: true,
                                minLeadingWidth: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.05),
                  color: const Color(0xffcccccc),
                  width: constraints.maxWidth * 0.9,
                  child: TextButton(
                    onPressed: () {
                      print('Return to PlaceManagerView');
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

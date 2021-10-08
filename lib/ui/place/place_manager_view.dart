import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';

class PlaceManagerView extends StatelessWidget {
  const PlaceManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: const Color(0xffeeeeee),
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
            body: Container(
              color: const Color(0xffeeeeee),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.025,
                      horizontal: constraints.maxWidth * 0.05,
                    ),
                    child: const Text('Saved Places'),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: const [
                            SizedBox(
                              height: 80,
                              child: Center(
                                child: ListTile(
                                  leading: Icon(Icons.home),
                                  title: Text('Home'),
                                  subtitle: Text(
                                    'Sunlight Drive, Sunny Hills Subdivision, Talamban, Cebu City, Philippines',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Icon(Icons.edit),
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                        Column(
                          children: const [
                            SizedBox(
                              height: 80,
                              child: Center(
                                child: ListTile(
                                  leading: Icon(Icons.work),
                                  title: Text('Work'),
                                  trailing: Icon(Icons.edit),
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                        const SizedBox(
                          height: 80,
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.add),
                              title: Text('Add New'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: constraints.maxHeight * 0.025,
                      horizontal: constraints.maxWidth * 0.05,
                    ),
                    child: const Text('Recently Used'),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: const [
                        SizedBox(
                          height: 80,
                          child: Center(
                            child: ListTile(
                              leading: Icon(Icons.access_time_rounded),
                              title: Text('University of San Carlos'),
                              subtitle: Text(
                                'Sunlight Drive, Sunny Hills Subdivision, Talamban, Cebu City, Philippines',
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Icon(Icons.bookmark_outline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

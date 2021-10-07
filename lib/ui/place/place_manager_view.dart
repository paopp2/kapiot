import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kapiot/app_router.dart';

class PlaceManagerView extends StatelessWidget {
  const PlaceManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
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
          body: Container(
            color: Color(0xffeeeeee),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.025,
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  child: Text('Saved Places'),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
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
                      SizedBox(
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
                  child: Text('Recently Used'),
                ),
                Container(
                  color: Colors.white,
                  child: const SizedBox(
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
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

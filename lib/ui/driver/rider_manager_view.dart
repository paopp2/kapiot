import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';

class RiderManagerView extends HookConsumerWidget {
  const RiderManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Color(0x7679ADFf),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 100.0),
                  Expanded(
                    flex: 1,
                    child: Text('Hello'),
                  ),
                  Expanded(
                    flex: 6,
                    child: Center(
                      //*! Provider is not final. Temporary only.
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.requestingRiders.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Text(model.requestingRiders[index],
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Accept'),
                                  ),
                                ],
                              ),
                            ));
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
              child: Center(
                //*! Provider is not final. Temporary only.
                child: ListView.builder(
                    itemCount: model.riderList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(model.requestingRiders[index]),
                        subtitle: Text('Rider'),
                      );
                    }),
              ),
            ),
          ),
        );
      },
    );
  }
}

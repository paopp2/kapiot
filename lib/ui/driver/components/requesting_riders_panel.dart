import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/request_manager_view_state.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';

class RequestingRidersPanel extends HookConsumerWidget {
  const RequestingRidersPanel({
    Key? key,
    required this.model,
  }) : super(key: key);

  final RiderManagerViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(riderManagerViewModel);
    final requestingRidersStream = ref.watch(requestingRidersStreamProvider);

    useEffect(() {
      model.initState();
      return model.dispose;
    }, []);

    return Expanded(
      child: Container(
        color: Colors.amber,
        child: Column(
          children: [
            const Text("REQUESTING RIDERS"),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.requestingRiders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png'),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(model.requestingRiders[index],
                              style: const TextStyle(fontSize: 20.0)),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Accept'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

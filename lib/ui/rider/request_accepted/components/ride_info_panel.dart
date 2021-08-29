import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/ui/shared/loading_widget.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class RideInfoPanel extends HookConsumerWidget {
  const RideInfoPanel(
      {Key? key, required this.model, required this.constraints})
      : super(key: key);

  final BoxConstraints constraints;
  final RequestAcceptedViewModel model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acceptingDriver = ref.watch(acceptingDriverProvider).state!;
    final coRidersStream = ref.watch(coRidersStreamProvider);
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          backgroundImage: NetworkImage(acceptingDriver.photoUrl!),
        ),
        SizedBox(height: constraints.maxHeight * 0.01),
        Text(acceptingDriver.displayName!),
        SizedBox(
          height: constraints.maxHeight * 0.01,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Colors.grey.shade200,
              ),
              height: constraints.maxHeight * 0.28,
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  const Center(
                    child: Text('Your co passengers for this ride'),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.015),
                  SizedBox(
                    height: constraints.maxHeight * 0.08,
                    child: coRidersStream.when(
                      error: (e, __) => Center(child: Text(e.toString())),
                      loading: () =>
                          const LoadingWidget(text: "Fetching co-riders..."),
                      data: (coRidersList) {
                        return Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: coRidersList.length,
                            itemBuilder: (context, index) {
                              final coRider = coRidersList[index];
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.blue,
                                  backgroundImage: NetworkImage(
                                    coRider.photoUrl ?? uscLogo,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: constraints.maxHeight * 0.12,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  const Text("Rider's reviews"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

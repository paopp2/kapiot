import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:marquee/marquee.dart';

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
    final acceptingDriverConfig =
        ref.watch(acceptingDriverConfigProvider).state!;
    final acceptingDriver = acceptingDriverConfig.user;
    final coRidersStream = ref.watch(coRidersStreamProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                top: constraints.maxHeight * 0.02,
                left: constraints.maxWidth * 0.04),
            height: constraints.maxHeight * 0.1,
            // color: Colors.blue,
            child: Text(
              '${acceptingDriver.displayName!.split(' ')[0]} is arriving in (time)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(acceptingDriver.photoUrl!),
              ),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.02,
                        ),
                        width: constraints.maxWidth * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 21,
                              child: Marquee(
                                text: acceptingDriver.displayName!,
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                                velocity: 40,
                                blankSpace: 30,
                                pauseAfterRound: const Duration(seconds: 2),
                              ),
                            ),
                            const Text(
                              'Suzuki Ertiga',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // width: constraints.maxWidth * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: constraints.maxWidth * 0.02),
                                  child: const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                                const Text('4.8',
                                    style: TextStyle(fontSize: 12))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: constraints.maxWidth * 0.02),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                  ),
                                ),
                                const Text(
                                  '9 mins',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // width: constraints.maxWidth * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Points',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                            Text('3.43')
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
            child: Column(
              children: [
                const Text('Your co-passengers for this ride'),
                SizedBox(
                  height: constraints.maxHeight * 0.08,
                  child: coRidersStream.when(
                    error: (e, __) => Center(child: Text(e.toString())),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    data: (coRidersList) {
                      return Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: coRidersList.length,
                          itemBuilder: (context, index) {
                            final coRider = coRidersList[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
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
          )
        ],
      ),
    );
  }
}

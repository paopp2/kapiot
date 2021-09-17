import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:dotted_line/dotted_line.dart';

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
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: constraints.maxHeight * 0.03),
              height: constraints.maxHeight * 0.075,
              child: Text(
                '${acceptingDriver.displayName!.split(' ')[0]} is arriving in (time)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: constraints.maxWidth * 0.02),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      image: DecorationImage(
                        image: NetworkImage(acceptingDriver.photoUrl!),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white54,
                          blurRadius: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 21,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    acceptingDriver.displayName!
                                            .split(' ')
                                            .first +
                                        ' ' +
                                        acceptingDriver.displayName!
                                            .split(' ')
                                            .last,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Text(
                                'Suzuki Ertiga',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: constraints.maxWidth * 0.02,
                                    ),
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
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: constraints.maxWidth * 0.02,
                                    ),
                                    child: const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  const Text(
                                    '4.8',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.01,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 15,
                            color: Colors.blue,
                          ),
                          DottedLine(
                            direction: Axis.vertical,
                            lineLength: constraints.maxHeight * 0.055,
                            dashColor: Colors.blue,
                            dashLength: 3,
                            dashRadius: 3,
                            lineThickness: 3,
                            dashGapLength: 2,
                          ),
                          const Icon(
                            Icons.location_on_rounded,
                            size: 20,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.05,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: constraints.maxHeight * 0.005,
                                    ),
                                    child: const Text(
                                      'home',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Pick-up Location',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.025,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: constraints.maxHeight * 0.005,
                                    ),
                                    child: const Text(
                                      'destination',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'Destination Location',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  height: 0.05,
                ),
              ],
            ),
            SizedBox(
              child: Column(
                children: [
                  const Text('Your co-passengers for this ride'),
                  SizedBox(
                    height: constraints.maxHeight * 0.075,
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
              margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(right: constraints.maxWidth * 0.015),
                    child: const Text(
                      'Ride Reward',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Text(
                    '3.43 points',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

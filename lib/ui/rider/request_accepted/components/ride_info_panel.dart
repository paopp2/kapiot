import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/ui/rider/request_accepted/components/divider_widget.dart';

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
    final driverNameSplit = acceptingDriver.displayName!.split(' ');
    final coRiderConfigsStream = ref.watch(coRiderConfigsStreamProvider);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: constraints.maxHeight * 0.05,
              child: Text(
                '${driverNameSplit.first} is arriving in 9 mins',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DividerWidget(constraints: constraints),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: constraints.maxHeight * 0.025,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: constraints.maxWidth * 0.02),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2.5,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(acceptingDriver.photoUrl!),
                            fit: BoxFit.fill,
                          ),
                        ),
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
                                      '${driverNameSplit.first} ${driverNameSplit.last}',
                                      style: const TextStyle(
                                        fontSize: 17,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                ),
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
            ),
            DividerWidget(constraints: constraints),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.02),
                  child: const Text(
                    'PASSENGERS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: coRiderConfigsStream.when(
                        error: (e, __) => Center(child: Text(e.toString())),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        data: (coRiderConfigsList) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: coRiderConfigsList.length,
                            itemBuilder: (context, index) {
                              final coRider = coRiderConfigsList[index].user;
                              return Align(
                                widthFactor: 0.8,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                      coRider.photoUrl ?? uscLogo,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const Text(
                      'You and n other people',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            DividerWidget(constraints: constraints),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.015),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: constraints.maxHeight * 0.005,
                      ),
                      child: const Text(
                        '10.0 points',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'Ride Reward',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

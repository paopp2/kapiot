import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_model.dart';
import 'package:kapiot/logic/rider/request_accepted/request_accepted_view_state.dart';
import 'package:kapiot/logic/shared/shared_state.dart';
import 'package:kapiot/logic/shared/extensions.dart';
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
    final driverName = acceptingDriver.displayName!;
    final estTimeArrival = ref.watch(driverArrivalTimeProvider).state;
    final coRiderConfigsStream = ref.watch(coRiderConfigsStreamProvider);
    final coRiderCount = ref.watch(coRiderCountProvider);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: constraints.maxHeight * 0.08,
              child: Text(
                '${driverName.firstName} is arriving in $estTimeArrival',
                style: GoogleFonts.montserrat(
                  fontSize: 17,
                  color: const Color(0xff333333),
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
                    margin: EdgeInsets.only(
                      right: constraints.maxWidth * 0.025,
                    ),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 21,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  '${driverName.firstName} ${driverName.lastName}',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 17,
                                    color: const Color(0xff333333),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rate,
                                  size: 18,
                                  color: Color(0xFFFDCC0D),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '4.8',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: const Color(0xFFAAAAAA),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.location,
                                  size: 18,
                                  color: Color(0xFFAAAAAA),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '9 mins',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: const Color(0xFFAAAAAA),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Image(
                              image: AssetImage(
                                  'assets/images/car_body_types/coupe.png'),
                              height: 50,
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(fontSize: 12),
                                children: [
                                  TextSpan(
                                    text: 'Toyota Fortuner - ',
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xFFAAAAAA),
                                      fontSize: 12,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'AAA 111',
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ],
                        )
                      ],
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
                  child: Text(
                    'Passengers',
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w500,
                    ),
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
                    Text(
                      coRiderConfigsStream.data!.value.isEmpty
                          ? 'You'
                          : 'You and $coRiderCount other people',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: const Color(0xFFAAAAAA),
                      ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: constraints.maxHeight * 0.005,
                      ),
                      child: Text(
                        '10.0 points',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Ride Reward',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: const Color(0xFFAAAAAA),
                      ),
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

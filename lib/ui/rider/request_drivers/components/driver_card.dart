import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_state.dart';
import 'package:kapiot/model/car/car.dart';
import 'package:kapiot/model/route_config/route_config.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class DriverCard extends HookConsumerWidget {
  const DriverCard({
    Key? key,
    required this.driverConfig,
    required this.model,
    required this.constraints,
    required this.index,
  }) : super(key: key);

  final ForDriver driverConfig;
  final RequestDriversViewModel model;
  final BoxConstraints constraints;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driverDistance = ref.watch(driverDistanceProvider).state;
    final selectedDriverIndex = ref.watch(selectedDriverIndexProvider).state;
    return Container(
      width: constraints.maxWidth * 0.6,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffF2F3F8),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => model
            ..selectDriver(index)
            ..previewDriverInfoAndLocation(driverConfig),
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          splashColor: const Color(0xFFF8F9FD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Visibility(
                  visible: selectedDriverIndex == index,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      color: Color(0xFF5F45A4),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.location,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            driverDistance,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 0.07,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: constraints.maxWidth * 0.025,
                              ),
                              width: 50,
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  driverConfig.user.photoUrl ?? uscLogo,
                                ),
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF5F45A4),
                                  width: 2,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      driverConfig.user.displayName ??
                                          'No name',
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: GoogleFonts.montserrat(
                                        color: const Color(0xff333333),
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.star_rate,
                                          size: 18,
                                          color: Color(0xFFFDCC0D),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          driverConfig.rating,
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff333333),
                                            fontSize: 13,
                                          ),
                                        ),
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
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${driverConfig.car.make} ${driverConfig.car.model}',
                                  style: GoogleFonts.montserrat(
                                    color: const Color(0xff333333),
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${driverConfig.car.licensePlateNum} - ',
                                        style: GoogleFonts.montserrat(
                                          color: const Color(0xFFAAAAAA),
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${driverConfig.currentRiderCount}/${driverConfig.maxRiderCount}',
                                        style: GoogleFonts.montserrat(
                                          color: const Color(0xFF5F45A4),
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ),
                          Image(
                            image: driverConfig.car.type.image,
                            height: constraints.maxHeight * 0.06,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => model.requestDriver(
                          driverConfig.user.id,
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF5F45A4),
                          elevation: 0,
                          fixedSize: Size(
                            constraints.maxWidth * 0.5,
                            40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Hail Ride',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

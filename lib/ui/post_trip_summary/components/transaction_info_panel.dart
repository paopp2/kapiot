import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_state.dart';
import 'package:kapiot/logic/post_trip/post_trip_summary_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/transaction/transaction.dart';
import 'package:kapiot/ui/post_trip_summary/components/panel_header.dart';

import 'info_block_widget.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class TransactionInfoPanel extends HookConsumerWidget {
  const TransactionInfoPanel({
    Key? key,
    required this.model,
    required this.constraints,
    required this.transaction,
    required this.isDriver,
    required this.driver,
  }) : super(key: key);

  final PostTripSummaryViewModel model;
  final BoxConstraints constraints;
  final Transaction transaction;
  final bool isDriver;
  final KapiotUser driver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startAddress = transaction.startLocation?.address ?? 'No start addr';
    final endAddress = transaction.endLocation?.address ?? 'No end addr';
    final riders = transaction.riders!.map((rc) => rc.user).toList();
    final distanceInKm = ref.watch(distanceInKmProvider);
    final timeInMins = ref.watch(timeInMinsProvider);
    final totalPoints = ref.watch(totalPointsProvider).state;
    const idNumber = '18105024';
    const plateNumber = 'FAG 169';

    return Entry(
      yOffset: 1000,
      delay: const Duration(milliseconds: 1000),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInToLinear,
      child: Container(
        height: constraints.maxHeight * 0.65,
        width: constraints.maxWidth,
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.05,
          vertical: constraints.maxHeight * 0.025,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff666666),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PanelHeader(
              isDriver: isDriver,
              constraints: constraints,
              driver: driver,
              idNumber: idNumber,
              plateNumber: plateNumber,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    startAddress,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xff574754),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    endAddress,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      color: const Color(0xff574754),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoBlockWidget(
                  constraints: constraints,
                  number: distanceInKm,
                  type: 'km',
                ),
                InfoBlockWidget(
                  constraints: constraints,
                  number: timeInMins,
                  type: 'minutes',
                ),
                InfoBlockWidget(
                  constraints: constraints,
                  number: totalPoints,
                  type: 'total points',
                ),
              ],
            ),
            Visibility(
              visible: riders.isNotEmpty,
              child: SizedBox(
                width: constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: isDriver,
                      child: Text(
                        'Passengers',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xff574754),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.85,
                      height: constraints.maxHeight * 0.1,
                      child: Center(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: riders.length,
                          itemBuilder: (context, index) {
                            final rider = riders[index];
                            return Align(
                              widthFactor: 0.8,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 27,
                                  backgroundImage: NetworkImage(
                                    rider.photoUrl ?? uscLogo,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Entry(
              xOffset: -1000,
              delay: const Duration(milliseconds: 1000),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeInToLinear,
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: model.resetToHomeView,
                  child: Text(
                    'home',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: const Color(
                        0xff666666,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      constraints.maxWidth * 0.25,
                      constraints.maxHeight * 0.06,
                    ),
                    side: const BorderSide(
                      color: Color(0xffdbb3d4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    primary: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

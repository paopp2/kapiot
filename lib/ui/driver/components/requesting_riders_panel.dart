import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class RequestingRidersPanel extends HookConsumerWidget {
  const RequestingRidersPanel({
    Key? key,
    required this.model,
    required this.constraints,
  }) : super(key: key);

  final RiderManagerViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestingRidersStream = ref.watch(requestingRidersStreamProvider);
    return SizedBox(
      height: constraints.maxHeight * 0.2,
      width: constraints.maxWidth,
      child: requestingRidersStream.when(
        error: (e, _) => Center(child: Text("Error $e")),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (requestingRiders) => CarouselSlider.builder(
          itemCount: requestingRiders.length,
          options: CarouselOptions(
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
            aspectRatio: 4 / 3,
            viewportFraction: 0.7,
          ),
          itemBuilder: (context, index, _) {
            final rider = requestingRiders[index];
            return Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.015,
                ),
                width: constraints.maxWidth * 0.8,
                child: Stack(
                  children: [
                    Material(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffF2F3F8),
                            width: 2,
                          ),
                          color: Colors.white,
                        ),
                        height: constraints.maxHeight * 0.13,
                        width: constraints.maxWidth * 0.8,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: constraints.maxWidth * 0.025,
                              ),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                elevation: 2.5,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    image: DecorationImage(
                                      image: NetworkImage(rider.photoUrl!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rider.displayName ?? 'No name',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      color: const Color(0xff333333),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                  Text(
                                    rider.userType!.description,
                                    style: GoogleFonts.montserrat(
                                      color: const Color(0xff333333),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: constraints.maxHeight * 0.06,
                        width: constraints.maxWidth * 0.4,
                        child: ElevatedButton(
                          onPressed: () => model.acceptRider(rider.id),
                          child: Text(
                            'Accept',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 17,
                              letterSpacing: 1.5,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF5F45A4),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/driver/rider_manager_view_model.dart';
import 'package:kapiot/logic/driver/rider_manager_view_state.dart';

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
      height: constraints.maxHeight * 0.18,
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
          ),
          itemBuilder: (context, index, _) {
            final rider = requestingRiders[index];
            return Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                child: Stack(
                  children: [
                    Material(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        height: constraints.maxHeight * 0.13,
                        width: constraints.maxWidth * 0.8,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.02,
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(rider.photoUrl!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                right: constraints.maxWidth * 0.02,
                              ),
                              height: constraints.maxHeight * 0.09,
                              width: constraints.maxWidth * 0.54,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('BS CPE 3'),
                                  Text(
                                    rider.displayName ?? 'No name',
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
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
                      child: InkWell(
                        onTap: () => model.acceptRider(rider.id),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          height: constraints.maxHeight * 0.06,
                          width: constraints.maxWidth * 0.4,
                          child: const Center(child: Text('Accept')),
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

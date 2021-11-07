import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_state.dart';
import 'package:kapiot/model/route_config/route_config.dart';

import 'driver_card.dart';

class DriverCardStream extends HookConsumerWidget {
  const DriverCardStream(
      {Key? key, required this.model, required this.constraints})
      : super(key: key);

  final RequestDriversViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compatibleDriverConfigStream =
        ref.watch(compatibleDriverConfigStreamProvider);
    return Builder(builder: (context) {
      return compatibleDriverConfigStream.when(
        error: (_, __) => const Center(
          child: Text('Error'),
        ),
        loading: () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage('assets/images/error/no_drivers.png'),
              height: constraints.maxHeight * 0.15,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    'No Drivers Found',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  Text(
                    "When you have compatible drivers along your\nroute, you'll see them here.",
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xFFAAAAAA),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
        data: (compatibleDriverConfigs) {
          return CarouselSlider.builder(
            itemCount: compatibleDriverConfigs.length,
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 4 / 3,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
            itemBuilder: (context, index, _) {
              final driverConfig = compatibleDriverConfigs[index];
              return DriverCard(
                driverConfig: driverConfig as ForDriver,
                model: model,
                constraints: constraints,
                index: index,
              );
            },
          );
        },
      );
    });
  }
}

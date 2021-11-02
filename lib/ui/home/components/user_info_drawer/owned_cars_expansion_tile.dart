import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/app_router.dart';
import 'package:kapiot/logic/home/home_view_model.dart';
import 'package:kapiot/model/car/car.dart';
import 'package:kapiot/model/kapiot_user_info/kapiot_user_info.dart';
import 'package:kapiot/logic/home/home_view_state.dart';

class OwnedCarsExpansionTile extends HookConsumerWidget {
  const OwnedCarsExpansionTile({
    Key? key,
    required this.constraints,
    required this.currentUserInfo,
    required this.model,
  }) : super(key: key);

  final BoxConstraints constraints;
  final HomeViewModel model;
  final KapiotUserInfo? currentUserInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownedCars = currentUserInfo?.driverInfo?.registeredCars;
    final chosenCar = ref.watch(chosenCarProvider).state;
    return ExpansionTile(
      leading: const Icon(
        Icons.drive_eta,
        size: 26,
        color: Color(0xffcccccc),
      ),
      title: Transform.translate(
        offset: const Offset(-14, 0),
        child: Text(
          'Vehicle',
          style: GoogleFonts.montserrat(
            color: const Color(0xff414141),
            fontSize: 16,
          ),
        ),
      ),
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ownedCars!.length + 1,
            itemBuilder: (context, index) {
              final isLastItem = (index == ownedCars.length);
              final car = (!isLastItem) ? ownedCars[index] : null;
              final isChosen = (chosenCar == car);
              return InkWell(
                onTap: () {
                  if (isLastItem) {
                    AppRouter.instance.navigateTo(
                      Routes.carRegisterView,
                    );
                  } else {
                    model.chooseCar(ownedCars[index]);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.015,
                    vertical: constraints.maxHeight * 0.025,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  width: isLastItem
                      ? constraints.maxWidth * 0.15
                      : constraints.maxWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isLastItem
                          ? [
                              Colors.white,
                              Colors.white,
                            ]
                          : (isChosen)
                              ? [
                                  const Color(0xFF5F45A4),
                                  const Color(0xFFBFB4DA),
                                  const Color(0xFFFFFFFF),
                                  const Color(0xFFBFB4DA),
                                  const Color(0xFF5F45A4),
                                ]
                              : [
                                  const Color(0xFFF5F5F5),
                                  const Color(0xFFFFFFFF),
                                  const Color(0xFFF5F5F5),
                                ],
                    ),
                  ),
                  child: (isLastItem)
                      ? const Icon(
                          Icons.add,
                          color: Color(0xFF5F45A4),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: car!.type.image,
                            ),
                            Text(
                              car.licensePlateNum.toUpperCase(),
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${car.make.toUpperCase()} ${car.model.toUpperCase()}',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                height: 0.7,
                                color: const Color(0xFF333333),
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

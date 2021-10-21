import 'package:flutter/material.dart';
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
      leading: const Icon(Icons.drive_eta),
      title: const Text(
        'Owned Cars',
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
                              const Color(0xffeeeeee),
                              const Color(0xffeaeaea),
                            ]
                          : (isChosen)
                              ? [
                                  const Color(0xffdbb3d4),
                                  const Color(0xffe9d1e5),
                                  const Color(0xffffffff),
                                  const Color(0xffe9d1e5),
                                  const Color(0xffaf8fa9),
                                ]
                              : [
                                  const Color(0xffeeeeee),
                                  const Color(0xffffffff),
                                  const Color(0xffa6a6a6),
                                ],
                    ),
                  ),
                  child: (isLastItem)
                      ? const Icon(Icons.add)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image: car!.type.image,
                            ),
                            Text(
                              car.licensePlateNum.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${car.make.toUpperCase()} ${car.model.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.fade,
                              ),
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

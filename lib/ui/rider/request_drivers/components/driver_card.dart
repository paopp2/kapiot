import 'package:flutter/material.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/model/route_config/route_config.dart';

const uscLogo =
    'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png';

class DriverCard extends StatelessWidget {
  const DriverCard(
      {Key? key,
      required this.driverConfig,
      required this.model,
      required this.constraints})
      : super(key: key);

  final RouteConfig driverConfig;
  final RequestDriversViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => model.previewDriverInfoAndLocation(driverConfig),
      splashColor: Colors.black,
      child: Container(
        width: constraints.maxWidth * 0.6,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                color: Color(0xffdbb3d4),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    Text(
                      '3 mins',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )
                  ],
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
                      height: 60,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: constraints.maxWidth * 0.025,
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue,
                              backgroundImage: NetworkImage(
                                driverConfig.user.photoUrl ?? uscLogo,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driverConfig.user.displayName ?? 'No name',
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.star,
                                        size: 18,
                                      ),
                                      Text(
                                        '4.6',
                                        style: TextStyle(
                                          fontSize: 12,
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
                              const Text(
                                'SUZUKI ERTIGA',
                                style: TextStyle(fontSize: 15),
                              ),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                      text: 'FAG 123 - ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    TextSpan(
                                      text: '4/6',
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: const [
                            Image(
                              image: AssetImage(
                                'assets/images/car_body_types/crossover.png',
                              ),
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                model.requestDriver(driverConfig.user.id),
                            child: const Text('Hail Ride'),
                          ),
                        ),
                      ],
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

import 'package:flutter/material.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/model/car/car.dart';
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

  final ForDriver driverConfig;
  final RequestDriversViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth * 0.6,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => model.previewDriverInfoAndLocation(driverConfig),
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          splashColor: Colors.black,
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
                  visible: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      color: Color(0xffdbb3d4),
                      // color: Colors.amber,
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
                            '0.5 km',
                            style: TextStyle(
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
                              child: CircleAvatar(
                                radius: constraints.maxHeight * 0.035,
                                backgroundColor: Colors.blue,
                                backgroundImage: NetworkImage(
                                  driverConfig.user.photoUrl ?? uscLogo,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: constraints.maxHeight * 0.07,
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
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 18,
                                        ),
                                        Text(
                                          driverConfig.rating,
                                          style: const TextStyle(
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
                                Text(
                                  '${driverConfig.car.make} ${driverConfig.car.model}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${driverConfig.car.licensePlateNum} - ',
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      TextSpan(
                                        text:
                                            '${driverConfig.currentRiderCount}/${driverConfig.maxRiderCount}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image(
                                image: driverConfig.car.type.image,
                                height: constraints.maxHeight * 0.06,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => model.requestDriver(
                                driverConfig.user.id,
                              ),
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
      ),
    );
  }
}

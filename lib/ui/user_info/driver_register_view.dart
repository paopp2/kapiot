import 'package:flutter/material.dart';

class DriverRegisterView extends StatelessWidget {
  const DriverRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextField(
                  decoration:
                      InputDecoration(hintText: 'License plate (eg. FAG 134)'),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  width: constraints.maxWidth,
                  child: Row(
                    children: const [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Car make  (eg. Suzuki)',
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Car model (eg. Ertiga)',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.025),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        VehicleType(
                          constraints: constraints,
                          vehicleIcon: Icon(Icons.car_rental),
                          vehicleLabel: 'Sedan',
                        ),
                        VehicleType(
                          constraints: constraints,
                          vehicleIcon: Icon(Icons.car_rental),
                          vehicleLabel: 'Hatchback',
                        ),
                        VehicleType(
                          constraints: constraints,
                          vehicleIcon: Icon(Icons.car_rental),
                          vehicleLabel: 'Pickup',
                        ),
                        VehicleType(
                          constraints: constraints,
                          vehicleIcon: Icon(Icons.car_rental),
                          vehicleLabel: 'SUV',
                        ),
                        VehicleType(
                          constraints: constraints,
                          vehicleIcon: Icon(Icons.car_rental),
                          vehicleLabel: 'AUV',
                        ),
                        VehicleType(
                          constraints: constraints,
                          vehicleIcon: Icon(Icons.car_rental),
                          vehicleLabel: 'Van',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VehicleType extends StatelessWidget {
  VehicleType(
      {Key? key,
      required this.constraints,
      required this.vehicleIcon,
      required this.vehicleLabel})
      : super(key: key);

  BoxConstraints constraints;
  Icon vehicleIcon;
  String vehicleLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('highlight ' + vehicleLabel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.025,
        ),
        height: constraints.maxWidth * 0.3,
        width: constraints.maxWidth * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            vehicleIcon,
            Text(vehicleLabel),
          ],
        ),
      ),
    );
  }
}

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
    return SizedBox(
      width: constraints.maxWidth * 0.6,
      child: Card(
        color: Colors.grey[100],
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => model.previewDriverInfoAndLocation(driverConfig),
          splashColor: Colors.black,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: constraints.maxHeight * 0.04,
                    bottom: constraints.maxHeight * 0.01),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage(
                    driverConfig.user.photoUrl ?? uscLogo,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(driverConfig.user.displayName ?? 'No name'),
              ),
              SizedBox(height: constraints.maxHeight * 0.05),
              ElevatedButton(
                onPressed: () => model.requestDriver(driverConfig.user.id),
                child: const Text('Hail Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

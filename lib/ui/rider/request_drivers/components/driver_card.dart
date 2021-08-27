import 'package:flutter/material.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class DriverCard extends StatelessWidget {
  const DriverCard(
      {Key? key,
      required this.driver,
      required this.model,
      required this.constraints})
      : super(key: key);

  final KapiotUser driver;
  final RequestDriversViewModel model;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Card(
        color: Colors.grey[100],
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            print('card tapped');
          },
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
                  backgroundImage: NetworkImage(driver.photoUrl!),
                ),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(driver.displayName ?? 'No name')),
              SizedBox(height: constraints.maxHeight * 0.15),
              ElevatedButton(
                onPressed: () => model.requestDriver(driver.id),
                child: const Text('Hail Ride'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

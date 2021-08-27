import 'package:flutter/material.dart';
import 'package:kapiot/logic/rider/request_drivers/request_drivers_view_model.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({
    Key? key,
    required this.driver,
    required this.model,
  }) : super(key: key);

  final KapiotUser driver;
  final RequestDriversViewModel model;

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
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage(driver.photoUrl!),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(driver.displayName ?? 'No name')),
              const SizedBox(height: 70),
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

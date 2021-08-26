import 'package:flutter/material.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class RideInfoPanel extends StatelessWidget {
  const RideInfoPanel(
      {Key? key, required this.acceptingDriver, required this.constraints})
      : super(key: key);

  final KapiotUser acceptingDriver;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          backgroundImage: NetworkImage(acceptingDriver.photoUrl!),
        ),
        const SizedBox(height: 10),
        Text(acceptingDriver.displayName!),
        const SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Colors.grey.shade200,
              ),
              height: constraints.maxHeight * 0.28,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text('Your co passengers for this ride'),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: constraints.maxHeight * 0.12,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  Text("Rider's reviews"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

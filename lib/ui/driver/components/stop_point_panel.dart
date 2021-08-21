import 'package:flutter/material.dart';

class NextStopPointPanel extends StatelessWidget {
  const NextStopPointPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("NEXT STOP POINT"),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.passerellesnumeriques.org/wp-content/uploads/2016/09/USC.png'),
            ),
            const Text("RIDER: Charles Ausejo Gwapo"),
            const Text("ACTION: Pick-up (or DropOff)"),
            const Text("WHERE: Skina Japan"),
            const Text("DISTANCE: 500m"),
            const Text("DETAILS: Wearing red shirt"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Done"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

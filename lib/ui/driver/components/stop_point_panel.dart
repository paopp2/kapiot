import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class StopPointPanel extends StatelessWidget {
  const StopPointPanel({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            // color: Color(0x8fffffff),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xafffffff), Color(0x00ffffff)]),
            borderRadius: BorderRadiusDirectional.circular(24)),
        margin: EdgeInsets.only(top: constraints.maxHeight * 0.025),
        padding: EdgeInsets.all(constraints.maxWidth * 0.025),
        height: 130,
        width: constraints.maxWidth * 0.8,
        child: Column(
          children: [
            SizedBox(
              width: constraints.maxWidth * 0.75,
              child: Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(right: constraints.maxWidth * 0.025),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Marquee(
                              text:
                                  'Sunlight Drive, Sunny Hills Subdivision, Talamban, Cebu City',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                              blankSpace: 90,
                              pauseAfterRound: const Duration(seconds: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "ACTION: ",
                  style: TextStyle(fontSize: 14),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('next stop point');
                  },
                  child: const Text("Done"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RequestAcceptedView extends StatelessWidget {
  const RequestAcceptedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Colors.yellow,
            child: Column(
              children: [
                const SizedBox(
                  height: 400,
                  width: double.infinity,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Paolo Pepito',
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 190,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text("Your co passengers for this ride"),
                                Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.blue,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(35),
                                    ),
                                  ),
                                  child: Column(
                                    children: const [
                                      Text("Rider's reviews"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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

// Column(
//                 children: [
//                   SizedBox(
//                     height: 400,
//                     width: double.infinity,
//                   ),
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(35),
//                           topRight: Radius.circular(35),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 30,
//                             width: 50,
//                             child: Divider(
//                               color: Colors.teal,
//                             ),
//                           ),
//                           Container(
//                             width: double.infinity,
//                             color: Colors.teal.shade100,
//                             margin: EdgeInsets.all(10),
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 CircleAvatar(
//                                   radius: 40,
//                                   backgroundColor: Colors.blue,
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   'Paolo Pepito',
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(35),
//                                   topRight: Radius.circular(35),
//                                 ),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text("Your co-passengers for today"),
//                                   Expanded(
//                                     child: ListView(
//                                       scrollDirection: Axis.horizontal,
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 40,
//                                           backgroundColor: Colors.blue,
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),

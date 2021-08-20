import 'package:flutter/material.dart';

class RequestDriversView extends StatelessWidget {
  const RequestDriversView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Container(
            color: Colors.blueGrey,
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 50,
                          child: Divider(
                            color: Colors.teal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("We found n drivers for your request "),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.all(20),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                width: 240,
                                color: Colors.teal.shade100,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
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
                                    ),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Center(child: Text("Hail ride")),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 240,
                                color: Colors.teal.shade100,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
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
                                      'Charles Ausejo',
                                    ),
                                    SizedBox(
                                      height: 70,
                                    ),
                                    Container(
                                      height: 35,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: Center(child: Text("Hail ride")),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

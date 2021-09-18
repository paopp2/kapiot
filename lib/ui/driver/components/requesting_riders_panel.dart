import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class RequestingRidersPanel extends StatelessWidget {
  const RequestingRidersPanel({Key? key, required this.constraints})
      : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight * 0.18,
      width: constraints.maxWidth,
      child: CarouselSlider(
        options: CarouselOptions(enlargeCenterPage: true),
        items: [
          Center(
            child: SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7)
                      ],
                    ),
                    height: constraints.maxHeight * 0.13,
                    width: constraints.maxWidth * 0.8,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.02),
                          height: constraints.maxHeight * 0.09,
                          width: constraints.maxWidth * 0.2,
                          color: Colors.amber,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: constraints.maxWidth * 0.02),
                          height: constraints.maxHeight * 0.09,
                          width: constraints.maxWidth * 0.54,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'time of booking here',
                              ),
                              Text(
                                'Name of rider',
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        print('rider has been accepted');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                        height: constraints.maxHeight * 0.06,
                        width: constraints.maxWidth * 0.4,
                        child: const Center(child: Text('Accept')),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

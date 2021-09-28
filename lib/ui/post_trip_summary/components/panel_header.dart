import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

class PanelHeader extends StatelessWidget {
  const PanelHeader({
    Key? key,
    required this.isDriver,
    required this.constraints,
    required this.driver,
    required this.idNumber,
    required this.plateNumber,
  }) : super(key: key);

  final bool isDriver;
  final BoxConstraints constraints;
  final KapiotUser driver;
  final String idNumber;
  final String plateNumber;

  @override
  Widget build(BuildContext context) {
    return isDriver
        ? Container(
            padding: const EdgeInsets.only(top: 25),
            width: constraints.maxWidth,
            child: Column(
              children: [
                Text(
                  driver.displayName ?? 'No Name',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: const Color(0xff333333),
                  ),
                ),
                Text(
                  idNumber,
                  style: GoogleFonts.poppins(
                    height: 1,
                    fontSize: 14,
                    color: const Color(0xff666666),
                  ),
                )
              ],
            ),
          )
        : Row(
            children: [
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(9),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(9),
                    image: DecorationImage(
                      image: NetworkImage(driver.photoUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: constraints.maxWidth * 0.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            driver.displayName ?? 'No Name',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: const Color(0xff333333),
                            ),
                          ),
                          Text(
                            plateNumber,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xff666666),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        idNumber,
                        style: GoogleFonts.poppins(
                          height: 1,
                          fontSize: 14,
                          color: const Color(0xff666666),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}

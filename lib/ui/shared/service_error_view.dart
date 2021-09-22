import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/service_error_handler.dart';

class ServiceErrorView extends HookConsumerWidget {
  const ServiceErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetEnabled = ref.watch(hasNetService).state;
    final locationEnabled = ref.watch(hasLocService).state;
    final hasPermission = ref.watch(hasLocPermission).state;
    final tempVar = (internetEnabled & locationEnabled & hasPermission);

    return LayoutBuilder(builder: (context, constraints) {
      return WillPopScope(
        onWillPop: () async => false, // Disallow going back from this View
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    tempVar
                        ? 'assets/images/error/no_resource.png'
                        : !internetEnabled
                            ? 'assets/images/error/no_connection.png'
                            : !locationEnabled || !hasPermission
                                ? 'assets/images/error/no_location.png'
                                : '',
                    height: constraints.maxHeight * 0.35,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.01,
                      bottom: constraints.maxHeight * 0.005,
                    ),
                    child: Text(
                      !internetEnabled ? 'No Connection' : 'we lost you.',
                      style: GoogleFonts.poppins(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333),
                      ),
                    ),
                  ),
                  Text(
                    tempVar
                        ? ''
                        : !internetEnabled
                            ? 'There seems to be a problem with your\nnetwork connection.'
                            : !locationEnabled
                                ? 'Enable your GPS and we\'ll find you in no time.'
                                : !hasPermission
                                    ? 'Share us your location and we\'ll take you back.'
                                    : '',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Color(0xff666666),
                    ),
                  ),
                  // Text("Internet enabled: $internetEnabled"),
                  // Text("Location enabled: $locationEnabled"),
                  // Text("Has location permission: $hasPermission"),
                  // Text('all three: $tempVar')
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/logic/shared/service_error_handler.dart';

class ServiceErrorView extends HookConsumerWidget {
  const ServiceErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final internetEnabled = ref.watch(hasNetService);
    final locationEnabled = ref.watch(hasLocService);
    final hasPermission = ref.watch(hasLocPermission);

    String getImageAssetName() {
      if (!hasPermission && !internetEnabled && !locationEnabled) {
        return 'assets/images/error/no_resource.png';
      }
      if (!hasPermission) return 'assets/images/error/no_permission.png';
      if (!internetEnabled) return 'assets/images/error/no_connection.png';
      if (!locationEnabled) return 'assets/images/error/no_location.png';
      return 'assets/images/error/error_catch.png';
    }

    String getErrorText() {
      if (!hasPermission && !internetEnabled && !locationEnabled) {
        return 'welp';
      }
      if (!hasPermission) return 'need permission';
      if (!internetEnabled) return 'no connection';
      if (!locationEnabled) return 'we lost you';
      return '';
    }

    String getErrorSubText() {
      if (!hasPermission && !internetEnabled && !locationEnabled) {
        return 'We wish to help you, but there\'s nothing we really can do for now.\n\nNo internet connection.\nLocation disabled.\nAccess to location forbidden.';
      }
      if (!hasPermission) {
        return 'Allow us access to your location and we\'ll take you back.';
      }
      if (!internetEnabled) {
        return 'We know how you feel.\n It\'s just that you lost your internet connection.';
      }
      if (!locationEnabled) {
        return 'Enable your GPS and we\'ll find you in no time.';
      }
      return '';
    }

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
                    getImageAssetName(),
                    height: constraints.maxHeight * 0.35,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.01,
                      bottom: constraints.maxHeight * 0.005,
                    ),
                    child: Text(
                      getErrorText(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff333333),
                      ),
                    ),
                  ),
                  Text(
                    getErrorSubText(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: const Color(0xff666666),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

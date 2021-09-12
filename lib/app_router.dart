import 'package:flutter/material.dart';
import 'package:kapiot/ui/auth/login_view.dart';
import 'package:kapiot/ui/driver/rider_manager_view.dart';
import 'package:kapiot/ui/driver/stop_points_view.dart';
import 'package:kapiot/ui/home/components/place_picker_view.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/portal_view.dart';
import 'package:kapiot/ui/rider/request_accepted/request_accepted_view.dart';
import 'package:kapiot/ui/rider/request_drivers/request_drivers_view.dart';
import 'package:kapiot/ui/shared/missing_service_view.dart';

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routesList = {
    Routes.portalView: (context) => const PortalView(),
    Routes.missingServiceView: (context) => const MissingServiceView(),
    Routes.homeView: (context) => const HomeView(),
    Routes.placePickerView: (context) => const PlacePickerView(),
    Routes.loginView: (context) => const LoginView(),
    Routes.riderManagerView: (context) => const RiderManagerView(),
    Routes.stopPointsView: (context) => const StopPointsView(),
    Routes.requestDriversView: (context) => const RequestDriversView(),
    Routes.requestAcceptedView: (context) => const RequestAcceptedView(),
  };

  Future<dynamic>? navigateTo(String route) =>
      navigationKey.currentState!.pushNamed(route);

  void popView() => navigationKey.currentState!.pop();

  void popAllThenNavigateTo(String route) =>
      navigationKey.currentState!.pushNamedAndRemoveUntil(route, (_) => false);
}

class Routes {
  static const portalView = 'portal_view';
  static const missingServiceView = 'missing_service_view';
  static const homeView = 'home/home_view';
  static const placePickerView = 'home/components/place_picker_view';
  static const loginView = 'auth/login_view';
  static const riderManagerView = 'driver/rider_manager_view';
  static const stopPointsView = 'driver/stop_points_view';
  static const requestDriversView = 'rider/request_drivers_view';
  static const requestAcceptedView = 'rider/request_accepted_view';
}

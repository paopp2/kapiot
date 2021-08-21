import 'package:flutter/material.dart';
import 'package:kapiot/ui/auth/login_view.dart';
import 'package:kapiot/ui/driver/rider_manager_view.dart';
import 'package:kapiot/ui/driver/stop_points_view.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/portal_view.dart';
import 'package:kapiot/ui/rider/request_accepted_view.dart';
import 'package:kapiot/ui/rider/request_drivers_view.dart';

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routesList = {
    Routes.portalView: (context) => const PortalView(),
    Routes.homeView: (context) => const HomeView(),
    Routes.loginView: (context) => const LoginView(),
    Routes.riderManagerView: (context) => const RiderManagerView(),
    Routes.stopPointsView: (context) => const StopPointsView(),
    Routes.requestDriversView: (context) => const RequestDriversView(),
    Routes.requestAcceptedView: (context) => const RequestAcceptedView(),
  };

  Future<dynamic>? navigateTo(String route) =>
      navigationKey.currentState?.pushNamed(route);

  void popView() => navigationKey.currentState?.pop();
}

class Routes {
  static const portalView = 'portalView';
  static const homeView = 'home/home_view';
  static const loginView = 'auth/login_view';
  static const riderManagerView = 'driver/rider_manager_view';
  static const stopPointsView = 'driver/stop_points_view';
  static const requestDriversView = 'rider/request_drivers_view';
  static const requestAcceptedView = 'rider/request_accepted_view';
}

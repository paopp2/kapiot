import 'package:flutter/material.dart';
import 'package:kapiot/ui/auth/login_view.dart';
import 'package:kapiot/ui/home/home_view.dart';

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routesList = {
    Routes.homeView: (context) => const HomeView(),
    Routes.loginView: (context) => const LoginView(),
  };

  Future<dynamic>? navigateToRoute(String route) {
    assert(navigationKey.currentState != null);
    navigationKey.currentState!.pushNamed(Routes.homeView);
  }

  void popView() => navigationKey.currentState?.pop();
}

class Routes {
  static const homeView = 'home/home_view';
  static const loginView = 'auth/login_view';
}

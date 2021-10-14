import 'package:flutter/material.dart';
import 'package:kapiot/ui/place/place_manager_view.dart';
import 'package:kapiot/ui/place/save_place_view.dart';
import 'package:kapiot/ui/post_trip_summary/post_trip_summary_view.dart';
import 'package:kapiot/ui/auth/login_view.dart';
import 'package:kapiot/ui/driver/rider_manager_view.dart';
import 'package:kapiot/ui/home/components/place_picker_view.dart';
import 'package:kapiot/ui/home/home_view.dart';
import 'package:kapiot/ui/portal_view.dart';
import 'package:kapiot/ui/rider/request_accepted/request_accepted_view.dart';
import 'package:kapiot/ui/rider/request_drivers/request_drivers_view.dart';
import 'package:kapiot/ui/shared/service_error_view.dart';
import 'package:kapiot/ui/user_info/car_register_view.dart';
import 'package:kapiot/ui/user_info/init_user_info_view.dart';

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  final Map<String, Widget Function(BuildContext)> routesList = {
    Routes.portalView: (context) => const PortalView(),
    Routes.serviceErrorView: (context) => const ServiceErrorView(),
    Routes.homeView: (context) => const HomeView(),
    Routes.initUserInfoView: (context) => const InitUserInfoView(),
    Routes.carRegisterView: (context) => const CarRegisterView(),
    Routes.placePickerView: (context) => const PlacePickerView(),
    Routes.loginView: (context) => const LoginView(),
    Routes.riderManagerView: (context) => const RiderManagerView(),
    Routes.requestDriversView: (context) => const RequestDriversView(),
    Routes.requestAcceptedView: (context) => const RequestAcceptedView(),
    Routes.postTripSummaryView: (context) => const PostTripSummaryView(),
    Routes.placeManagerView: (context) => const PlaceManagerView(),
    Routes.savePlaceView: (context) => const SavePlaceView(),
  };

  Future<dynamic>? navigateTo(String route, {Object? args}) =>
      navigationKey.currentState!.pushNamed(route, arguments: args);

  void popView() => navigationKey.currentState!.pop();

  void popAllThenNavigateTo(String route) =>
      navigationKey.currentState!.pushNamedAndRemoveUntil(route, (_) => false);
}

class Routes {
  static const portalView = 'portal_view';
  static const serviceErrorView = 'service_error_view';
  static const homeView = 'home/home_view';
  static const initUserInfoView = 'home/edit_user_info_view';
  static const carRegisterView = 'home/car_register_view';
  static const placePickerView = 'home/components/place_picker_view';
  static const loginView = 'auth/login_view';
  static const riderManagerView = 'driver/rider_manager_view';
  static const requestDriversView = 'rider/request_drivers_view';
  static const requestAcceptedView = 'rider/request_accepted_view';
  static const postTripSummaryView = 'post_trip_summary_view';
  static const placeManagerView = 'place/place_manager_view';
  static const savePlaceView = 'place/save_place_view';
}

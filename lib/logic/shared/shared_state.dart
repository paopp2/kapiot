import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final currentRouteConfigProvider = StateProvider.autoDispose<RouteConfig?>(
  (ref) {
    ref.maintainState = true;
    return null;
  },
);

final acceptingDriverProvider = StateProvider.autoDispose<KapiotUser?>((ref) {
  ref.maintainState = true;
  return null;
});

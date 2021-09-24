import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/route_config/route_config.dart';

final currentRouteConfigProvider = StateProvider.autoDispose<RouteConfig?>(
  (ref) {
    ref.maintainState = true;
    return null;
  },
);

final acceptingDriverConfigProvider =
    StateProvider.autoDispose<RouteConfig?>((ref) {
  ref.maintainState = true;
  return null;
});

final riderConfigListProvider =
    StateProvider.autoDispose<List<RouteConfig>>((ref) {
  ref.maintainState = true;
  return [];
});

final resetKeyProvider = StateProvider.autoDispose((ref) => UniqueKey());

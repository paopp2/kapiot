import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/route_config/route_config.dart';
import 'package:kapiot/model/transaction/transaction.dart';

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

final transactionProvider = StateProvider.autoDispose<Transaction>((ref) {
  ref.maintainState = true;
  return const Transaction();
});

final resetKeyProvider = StateProvider.autoDispose((ref) => UniqueKey());

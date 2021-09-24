import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/route_config/route_config.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String currentUserId,
    required RouteConfig driver,
    required List<RouteConfig> riders,
    required int points,
    required DateTime startTime,
    required DateTime endTime,
    required double distance,
  }) = _Transaction;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/route_config/route_config.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    String? currentUserId,
    RouteConfig? driver,
    List<RouteConfig>? riders,
    int? points,
    DateTime? startTime,
    DateTime? endTime,
    double? distance,
  }) = _Transaction;
}

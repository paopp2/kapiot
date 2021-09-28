import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    String? currentUserId,
    RouteConfig? driver,
    List<RouteConfig>? riders,
    KapiotLocation? startLocation,
    KapiotLocation? endLocation,
    double? points,
    DateTime? startTime,
    DateTime? endTime,
    double? distance,
  }) = _Transaction;
}

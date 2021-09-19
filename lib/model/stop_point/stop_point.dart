import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/route_config/route_config.dart';

part 'stop_point.freezed.dart';

@freezed
class StopPoint with _$StopPoint {
  const factory StopPoint({
    required RouteConfig riderConfig,
    required KapiotLocation stopLocation,
    required bool isPickUp,
  }) = _StopPoint;
}

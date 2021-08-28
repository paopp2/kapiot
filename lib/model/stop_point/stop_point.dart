import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

part 'stop_point.freezed.dart';

@freezed
class StopPoint with _$StopPoint {
  const factory StopPoint({
    required String id,
    required KapiotUser rider,
    required KapiotLocation stopLocation,
    required bool isPickUp,
  }) = _StopPoint;
}

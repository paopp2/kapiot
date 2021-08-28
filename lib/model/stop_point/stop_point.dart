import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

part 'stop_point.freezed.dart';

enum StopPointAction {
  pickUp,
  dropOff,
}

@freezed
class StopPoint with _$StopPoint {
  const factory StopPoint({
    required KapiotUser rider,
    required KapiotLocation startLoc,
    required KapiotLocation endLoc,
    required StopPointAction action,
  }) = _StopPoint;
}

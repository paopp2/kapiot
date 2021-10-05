import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  const UserInfo._();
  const factory UserInfo({
    required double points,
    required String course,
    required int year,
    required List<Map<String, KapiotLocation>> savedLocations,
    DriverInfo? driverInfo,
  }) = _UserInfo;

  bool get isRegisteredDriver => (driverInfo != null);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/driver_info/driver_info.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const UserInfo._();
  const factory UserInfo({
    required double points,
    required List<Map<String, KapiotLocation>> savedLocations,
    required UserType userType,
    required int rideCount,
    DriverInfo? driverInfo,
  }) = _UserInfo;

  bool get isRegisteredDriver => (driverInfo != null);

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

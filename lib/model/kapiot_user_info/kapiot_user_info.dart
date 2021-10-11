import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/driver_info/driver_info.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';

part 'kapiot_user_info.freezed.dart';
part 'kapiot_user_info.g.dart';

@freezed
class KapiotUserInfo with _$KapiotUserInfo {
  const KapiotUserInfo._();
  const factory KapiotUserInfo({
    required double points,
    required Map<String, KapiotLocation> savedLocations,
    required UserType userType,
    DriverInfo? driverInfo,
  }) = _KapiotUserInfo;

  bool get isRegisteredDriver => (driverInfo != null);

  factory KapiotUserInfo.fromJson(Map<String, dynamic> json) =>
      _$KapiotUserInfoFromJson(json);
}

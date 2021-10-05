import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    double? points,
    String? course,
    int? year,
    List<Map<String, KapiotLocation>> savedLocations,
  }) = _UserInfo;
}

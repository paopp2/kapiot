import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'kapiot_location.freezed.dart';
part 'kapiot_location.g.dart';

@freezed
class KapiotLocation with _$KapiotLocation {
  const factory KapiotLocation({
    required double lat,
    required double lng,
  }) = _KapiotLocation;

  factory KapiotLocation.fromJson(Map<String, dynamic> json) =>
      _$KapiotLocationFromJson(json);
}

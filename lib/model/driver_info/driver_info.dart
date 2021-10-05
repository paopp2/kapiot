import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/car/car.dart';

part 'driver_info.freezed.dart';
part 'driver_info.g.dart';

@freezed
class DriverInfo with _$DriverInfo {
  const factory DriverInfo({
    required String licensePlateNum,
    required List<Car> registeredCars,
    double? rating,
  }) = _DriverInfo;

  factory DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoFromJson(json);
}

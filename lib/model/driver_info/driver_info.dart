import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/car/car.dart';

part 'driver_info.freezed.dart';
part 'driver_info.g.dart';

@freezed
class DriverInfo with _$DriverInfo {
  const DriverInfo._();
  const factory DriverInfo({
    required List<Car> registeredCars,
    @Default(0) int ratingResponseCount,
    @Default(0) double rateTotal,
  }) = _DriverInfo;

  String get averageRating {
    return (rateTotal > 0 || ratingResponseCount > 0)
        ? (rateTotal / ratingResponseCount).toStringAsFixed(1)
        : 'Unrated';
  }

  factory DriverInfo.fromJson(Map<String, dynamic> json) =>
      _$DriverInfoFromJson(json);
}

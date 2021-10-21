import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/car/car.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

part 'route_config.freezed.dart';
part 'route_config.g.dart';

@freezed
class RouteConfig with _$RouteConfig {
  const RouteConfig._();
  const factory RouteConfig.rider({
    required KapiotUser user,
    required DateTime timeOfTrip,
    required KapiotLocation startLocation,
    required KapiotLocation endLocation,
    required int riderCount,
    RouteConfig? acceptingDriverConfig,
  }) = ForRider;

  const factory RouteConfig.driver({
    required KapiotUser user,
    required DateTime timeOfTrip,
    required KapiotLocation startLocation,
    required KapiotLocation endLocation,
    required String encodedRoute,
    @Default(0) int currentRiderCount,
    required int maxRiderCount,
    required Car car,
  }) = ForDriver;

  /// Determines whether a driver's car is holding the maximum number of riders
  ///
  /// This will only work if the RouteConfig is ForDriver. Otherwise, this
  /// getter will throw
  bool get isCarFull {
    final driverConfig = this as ForDriver;
    return (driverConfig.maxRiderCount == driverConfig.currentRiderCount);
  }

  factory RouteConfig.fromJson(Map<String, dynamic> json) =>
      _$RouteConfigFromJson(json);
}

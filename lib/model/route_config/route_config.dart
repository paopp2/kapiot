import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:kapiot/model/kapiot_user/kapiot_user.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

part 'route_config.freezed.dart';
part 'route_config.g.dart';

@freezed
class RouteConfig with _$RouteConfig {
  const factory RouteConfig.rider({
    required KapiotUser user,
    required DateTime timeOfTrip,
    required int riderCount,
    required KapiotLocation startLocation,
    required KapiotLocation endLocation,
    KapiotUser? acceptingDriver,
  }) = ForRider;

  const factory RouteConfig.driver({
    required KapiotUser user,
    required DateTime timeOfTrip,
    required int riderCount,
    required String encodedRoute,
  }) = ForDriver;

  factory RouteConfig.fromJson(Map<String, dynamic> json) =>
      _$RouteConfigFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForRider _$$ForRiderFromJson(Map<String, dynamic> json) => _$ForRider(
      user: KapiotUser.fromJson(json['user'] as Map<String, dynamic>),
      timeOfTrip: DateTime.parse(json['timeOfTrip'] as String),
      startLocation: KapiotLocation.fromJson(
          json['startLocation'] as Map<String, dynamic>),
      endLocation:
          KapiotLocation.fromJson(json['endLocation'] as Map<String, dynamic>),
      riderCount: json['riderCount'] as int,
      acceptingDriverConfig: json['acceptingDriverConfig'] == null
          ? null
          : RouteConfig.fromJson(
              json['acceptingDriverConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ForRiderToJson(_$ForRider instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'timeOfTrip': instance.timeOfTrip.toIso8601String(),
      'startLocation': instance.startLocation.toJson(),
      'endLocation': instance.endLocation.toJson(),
      'riderCount': instance.riderCount,
      'acceptingDriverConfig': instance.acceptingDriverConfig?.toJson(),
    };

_$ForDriver _$$ForDriverFromJson(Map<String, dynamic> json) => _$ForDriver(
      user: KapiotUser.fromJson(json['user'] as Map<String, dynamic>),
      timeOfTrip: DateTime.parse(json['timeOfTrip'] as String),
      startLocation: KapiotLocation.fromJson(
          json['startLocation'] as Map<String, dynamic>),
      endLocation:
          KapiotLocation.fromJson(json['endLocation'] as Map<String, dynamic>),
      encodedRoute: json['encodedRoute'] as String,
      currentRiderCount: json['currentRiderCount'] as int? ?? 0,
      maxRiderCount: json['maxRiderCount'] as int,
      car: Car.fromJson(json['car'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ForDriverToJson(_$ForDriver instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'timeOfTrip': instance.timeOfTrip.toIso8601String(),
      'startLocation': instance.startLocation.toJson(),
      'endLocation': instance.endLocation.toJson(),
      'encodedRoute': instance.encodedRoute,
      'currentRiderCount': instance.currentRiderCount,
      'maxRiderCount': instance.maxRiderCount,
      'car': instance.car.toJson(),
    };

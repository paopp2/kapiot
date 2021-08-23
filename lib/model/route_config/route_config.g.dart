// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForRider _$$ForRiderFromJson(Map<String, dynamic> json) => _$ForRider(
      user: KapiotUser.fromJson(json['user'] as Map<String, dynamic>),
      timeOfTrip: DateTime.parse(json['timeOfTrip'] as String),
      riderCount: json['riderCount'] as int,
      startLocation: KapiotLocation.fromJson(
          json['startLocation'] as Map<String, dynamic>),
      endLocation:
          KapiotLocation.fromJson(json['endLocation'] as Map<String, dynamic>),
      acceptingDriver: json['acceptingDriver'] == null
          ? null
          : KapiotUser.fromJson(
              json['acceptingDriver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ForRiderToJson(_$ForRider instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'timeOfTrip': instance.timeOfTrip.toIso8601String(),
      'riderCount': instance.riderCount,
      'startLocation': instance.startLocation.toJson(),
      'endLocation': instance.endLocation.toJson(),
      'acceptingDriver': instance.acceptingDriver?.toJson(),
    };

_$ForDriver _$$ForDriverFromJson(Map<String, dynamic> json) => _$ForDriver(
      user: KapiotUser.fromJson(json['user'] as Map<String, dynamic>),
      timeOfTrip: DateTime.parse(json['timeOfTrip'] as String),
      riderCount: json['riderCount'] as int,
      encodedRoute: json['encodedRoute'] as String,
    );

Map<String, dynamic> _$$ForDriverToJson(_$ForDriver instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
      'timeOfTrip': instance.timeOfTrip.toIso8601String(),
      'riderCount': instance.riderCount,
      'encodedRoute': instance.encodedRoute,
    };

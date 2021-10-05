// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      points: (json['points'] as num).toDouble(),
      course: json['course'] as String,
      year: json['year'] as int,
      savedLocations: (json['savedLocations'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, KapiotLocation.fromJson(e as Map<String, dynamic>)),
              ))
          .toList(),
      driverInfo: json['driverInfo'] == null
          ? null
          : DriverInfo.fromJson(json['driverInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'points': instance.points,
      'course': instance.course,
      'year': instance.year,
      'savedLocations': instance.savedLocations
          .map((e) => e.map((k, e) => MapEntry(k, e.toJson())))
          .toList(),
      'driverInfo': instance.driverInfo?.toJson(),
    };

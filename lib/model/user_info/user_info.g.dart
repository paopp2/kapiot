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
      userType: _$enumDecode(_$UserTypeEnumMap, json['userType']),
      rideCount: json['rideCount'] as int,
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
      'userType': _$UserTypeEnumMap[instance.userType],
      'rideCount': instance.rideCount,
      'driverInfo': instance.driverInfo?.toJson(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$UserTypeEnumMap = {
  UserType.student: 'student',
  UserType.faculty: 'faculty',
  UserType.personnel: 'personnel',
};

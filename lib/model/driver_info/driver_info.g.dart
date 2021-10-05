// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DriverInfo _$$_DriverInfoFromJson(Map<String, dynamic> json) =>
    _$_DriverInfo(
      licensePlateNum: json['licensePlateNum'] as String,
      registeredCars: (json['registeredCars'] as List<dynamic>)
          .map((e) => Car.fromJson(e as Map<String, dynamic>))
          .toList(),
      passengerCount: json['passengerCount'] as int,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_DriverInfoToJson(_$_DriverInfo instance) =>
    <String, dynamic>{
      'licensePlateNum': instance.licensePlateNum,
      'registeredCars': instance.registeredCars.map((e) => e.toJson()).toList(),
      'passengerCount': instance.passengerCount,
      'rating': instance.rating,
    };

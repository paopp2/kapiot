// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DriverInfo _$$_DriverInfoFromJson(Map<String, dynamic> json) =>
    _$_DriverInfo(
      registeredCars: (json['registeredCars'] as List<dynamic>)
          .map((e) => Car.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_DriverInfoToJson(_$_DriverInfo instance) =>
    <String, dynamic>{
      'registeredCars': instance.registeredCars.map((e) => e.toJson()).toList(),
      'rating': instance.rating,
    };

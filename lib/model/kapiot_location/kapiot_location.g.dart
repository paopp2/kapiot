// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kapiot_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KapiotLocation _$$_KapiotLocationFromJson(Map<String, dynamic> json) =>
    _$_KapiotLocation(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$_KapiotLocationToJson(_$_KapiotLocation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
    };

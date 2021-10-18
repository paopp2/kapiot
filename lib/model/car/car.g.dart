// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Car _$$_CarFromJson(Map<String, dynamic> json) => _$_Car(
      licensePlateNum: json['licensePlateNum'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      type: _$enumDecode(_$CarTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_CarToJson(_$_Car instance) => <String, dynamic>{
      'licensePlateNum': instance.licensePlateNum,
      'make': instance.make,
      'model': instance.model,
      'type': _$CarTypeEnumMap[instance.type],
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

const _$CarTypeEnumMap = {
  CarType.coupe: 'coupe',
  CarType.sedan: 'sedan',
  CarType.hatchback: 'hatchback',
  CarType.pickup: 'pickup',
  CarType.suv: 'suv',
  CarType.mpv: 'mpv',
  CarType.wagon: 'wagon',
  CarType.crossover: 'crossover',
  CarType.van: 'van',
};

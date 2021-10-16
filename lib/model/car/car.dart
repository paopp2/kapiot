import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'car.freezed.dart';
part 'car.g.dart';

@freezed
class Car with _$Car {
  const Car._();
  const factory Car({
    required String licensePlateNum,
    required String make,
    required String model,
    required CarType type,
  }) = _Car;

  int get capacity => type.capacity;

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
}

enum CarType {
  coupe,
  sedan,
  hatchback,
  pickup,
  suv,
  mpv,
  wagon,
  multicab,
  van,
}

extension CarTypeMeta on CarType {
  int get capacity => meta['capacity'];
  Icon get icon => meta['icon'];
  String get label => meta['label'];

  Map<String, dynamic> get meta {
    switch (this) {
      case CarType.coupe:
        return {
          'capacity': 2,
          'icon': const Icon(Icons.car_rental),
          'label': 'Coupe',
        };
      case CarType.sedan:
        return {
          'capacity': 2,
          'icon': const Icon(Icons.car_rental),
          'label': 'Sedan',
        };
      case CarType.hatchback:
        return {
          'capacity': 2,
          'icon': const Icon(Icons.car_rental),
          'label': 'Hatchback',
        };
      case CarType.pickup:
        return {
          'capacity': 5,
          'icon': const Icon(Icons.car_rental),
          'label': 'Pickup',
        };
      case CarType.suv:
        return {
          'capacity': 5,
          'icon': const Icon(Icons.car_rental),
          'label': 'SUV',
        };
      case CarType.mpv:
        return {
          'capacity': 5,
          'icon': const Icon(Icons.car_rental),
          'label': 'MPV',
        };
      case CarType.wagon:
        return {
          'capacity': 5,
          'icon': const Icon(Icons.car_rental),
          'label': 'Wagon',
        };
      case CarType.multicab:
        return {
          'capacity': 8,
          'icon': const Icon(Icons.car_rental),
          'label': 'Multicab',
        };
      case CarType.van:
        return {
          'capacity': 8,
          'icon': const Icon(Icons.car_rental),
          'label': 'Van',
        };
    }
  }
}

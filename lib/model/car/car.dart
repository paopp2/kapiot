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
  crossover,
  suv,
  mpv,
  wagon,
  van,
}

extension CarTypeMeta on CarType {
  int get capacity => meta['capacity'];
  AssetImage get icon => meta['icon'];
  String get label => meta['label'];

  Map<String, dynamic> get meta {
    switch (this) {
      case CarType.coupe:
        return {
          'capacity': 2,
          'icon': const AssetImage('assets/images/car_body_types/coupe.png'),
          'label': 'Coupe',
        };
      case CarType.sedan:
        return {
          'capacity': 5,
          'icon': const AssetImage('assets/images/car_body_types/sedan.png'),
          'label': 'Sedan',
        };
      case CarType.hatchback:
        return {
          'capacity': 5,
          'icon':
              const AssetImage('assets/images/car_body_types/hatchback.png'),
          'label': 'Hatchback',
        };
      case CarType.pickup:
        return {
          'capacity': 5,
          'icon':
              const AssetImage('assets/images/car_body_types/pickup_truck.png'),
          'label': 'Pickup Truck',
        };
      case CarType.crossover:
        return {
          'capacity': 5,
          'icon':
              const AssetImage('assets/images/car_body_types/crossover.png'),
          'label': 'Crossover',
        };
      case CarType.suv:
        return {
          'capacity': 7,
          'icon': const AssetImage('assets/images/car_body_types/suv.png'),
          'label': 'SUV',
        };
      case CarType.mpv:
        return {
          'capacity': 7,
          'icon': const AssetImage('assets/images/car_body_types/mpv.png'),
          'label': 'MPV',
        };
      case CarType.wagon:
        return {
          'capacity': 7,
          'icon': const AssetImage(
              'assets/images/car_body_types/station_wagon.png'),
          'label': 'Station Wagon',
        };
      case CarType.van:
        return {
          'capacity': 12,
          'icon': const AssetImage('assets/images/car_body_types/van.png'),
          'label': 'Van',
        };
    }
  }
}

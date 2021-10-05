import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'car.freezed.dart';
part 'car.g.dart';

enum CarType {
  sedan,
  truck,
  hatchback,
  suv,
  auv,
  van,
}

@freezed
class Car with _$Car {
  const Car._();
  const factory Car({
    required String make,
    required String model,
    required CarType type,
  }) = _Car;

  int get capacity {
    switch (type) {
      case CarType.hatchback:
        return 2;
      case CarType.sedan:
        return 2;
      case CarType.truck:
        return 5;
      case CarType.auv:
        return 5;
      case CarType.suv:
        return 5;
      case CarType.van:
        return 8;
    }
  }

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
}

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
  CarImage get icon => meta['icon'];
  String get label => meta['label'];

  Map<String, dynamic> get meta {
    switch (this) {
      case CarType.coupe:
        return {
          'capacity': 2,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/coupe.png'),
          ),
          'label': 'Coupe',
        };
      case CarType.sedan:
        return {
          'capacity': 5,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/sedan.png'),
          ),
          'label': 'Sedan',
        };
      case CarType.hatchback:
        return {
          'capacity': 5,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/hatchback.png'),
          ),
          'label': 'Hatchback',
        };
      case CarType.pickup:
        return {
          'capacity': 5,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/pickup_truck.png'),
          ),
          'label': 'Pickup Truck',
        };
      case CarType.crossover:
        return {
          'capacity': 5,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/crossover.png'),
          ),
          'label': 'Crossover',
        };
      case CarType.suv:
        return {
          'capacity': 7,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/suv.png'),
          ),
          'label': 'SUV',
        };
      case CarType.mpv:
        return {
          'capacity': 7,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/mpv.png'),
          ),
          'label': 'MPV',
        };
      case CarType.wagon:
        return {
          'capacity': 7,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/station_wagon.png'),
          ),
          'label': 'Station Wagon',
        };
      case CarType.van:
        return {
          'capacity': 12,
          'icon': CarImage(
            image: const AssetImage('assets/images/car_two/van.png'),
          ),
          'label': 'Van',
        };
    }
  }
}

class CarImage extends StatelessWidget {
  CarImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  AssetImage image;
  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      height: 110,
    );
  }
}

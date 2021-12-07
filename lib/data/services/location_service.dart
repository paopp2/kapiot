import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final locationServiceProvider =
    Provider.autoDispose((ref) => LocationService(ref.read));

class LocationService {
  LocationService(this.read) {
    // In order to be able to listen to changes for when the location service
    // is enabled/disabled on top of being able to control the stream, manually
    // add them through the serviceStatusController which can also be utilized
    // wherever
    Geolocator.getServiceStatusStream().listen(
      (status) => serviceStatusController.add(status),
    );
  }
  final Reader read;
  final serviceStatusController = StreamController<ServiceStatus>();
  final permissionStatusController =
      StreamController<LocationPermission>.broadcast();

  Future<Either<Exception, KapiotLocation>> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) Geolocator.openAppSettings();
    final locPermission = await Geolocator.checkPermission();
    if (locPermission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    try {
      final position = await Geolocator.getCurrentPosition();
      return Right(KapiotLocation(
        lat: position.latitude,
        lng: position.longitude,
      ));
    } catch (e) {
      e as Exception;
      switch (e.runtimeType) {
        case LocationServiceDisabledException:
          serviceStatusController.add(ServiceStatus.disabled);
          break;
        case PermissionDeniedException:
          permissionStatusController.add(LocationPermission.denied);
          break;
      }
      return Left(e);
    }
  }

  Future<Either<Exception, String>> getAddressFromLocation(
    KapiotLocation location,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.lat,
        location.lng,
      );
      final p = placemarks[0];
      return Right(
        "${p.name}, ${p.locality}, ${p.subAdministrativeArea}, ${p.administrativeArea}, ${p.country}",
      );
    } catch (e) {
      e as Exception;
      return Left(e);
    }
  }

  // TODO: Error-handling for getLocationStream
  Stream<KapiotLocation> getLocationStream() {
    final positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(distanceFilter: 5),
    );
    return positionStream.map(
      (pos) => KapiotLocation(
        lat: pos.latitude,
        lng: pos.longitude,
      ),
    );
  }
}

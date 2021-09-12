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
  final permissionStatusController = StreamController<LocationPermission>();

  Future<Either<Exception, KapiotLocation>> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) Geolocator.openAppSettings();
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

  // TODO: Error-handling for getAddressFromLocation
  Future<String?> getAddressFromLocation(KapiotLocation location) async {
    final placemarks = await placemarkFromCoordinates(
      location.lat,
      location.lng,
    );
    final p = placemarks[0];
    return "${p.name}, ${p.locality}, ${p.subAdministrativeArea}, ${p.administrativeArea}, ${p.country}";
  }

  // TODO: Error-handling for getLocationStream
  Stream<KapiotLocation> getLocationStream() {
    final positionStream = Geolocator.getPositionStream(
      distanceFilter: 5,
    );
    return positionStream.map(
      (pos) => KapiotLocation(
        lat: pos.latitude,
        lng: pos.longitude,
      ),
    );
  }
}

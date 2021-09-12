import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final locationServiceProvider =
    Provider.autoDispose((ref) => LocationService(ref.read));

class LocationService {
  LocationService(this.read);
  final Reader read;
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
          break;
        case PermissionDeniedException:
          break;
      }
      return Left(e);
    }
  }

  Future<String?> getAddressFromLocation(KapiotLocation location) async {
    final placemarks = await placemarkFromCoordinates(
      location.lat,
      location.lng,
    );
    final p = placemarks[0];
    return "${p.name}, ${p.locality}, ${p.subAdministrativeArea}, ${p.administrativeArea}, ${p.country}";
  }

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

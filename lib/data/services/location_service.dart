import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final locationServiceProvider =
    Provider.autoDispose((ref) => LocationService());

class LocationService {
  Future<Either<Exception, KapiotLocation>> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Geolocator.openAppSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return Right(KapiotLocation(
        lat: position.latitude,
        lng: position.longitude,
      ));
    } catch (e) {
      return Left(e as Exception);
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

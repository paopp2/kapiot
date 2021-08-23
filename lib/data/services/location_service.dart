import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final locationServiceProvider =
    Provider.autoDispose((ref) => LocationService());

class LocationService {
  Future<KapiotLocation> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // TODO: Handle when Location services are disabled
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // TODO: Handle when Location permission denied
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // TODO: Handle when Location permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    return KapiotLocation(
      lat: position.latitude,
      lng: position.longitude,
    );
  }

  Future<KapiotLocation> getLocationFromAddress(String address) async {
    final locationList = await locationFromAddress(address);
    final firstGeoLocation = locationList[0]; // Return the first location
    return KapiotLocation(
      lat: firstGeoLocation.latitude,
      lng: firstGeoLocation.longitude,
    );
  }

  Future<String?> getAddressFromLocation(KapiotLocation location) async {
    final placemarks = await placemarkFromCoordinates(
      location.lat,
      location.lng,
    );
    final p = placemarks[0];
    return "${p.name}, ${p.locality}, ${p.subAdministrativeArea}, ${p.administrativeArea}, ${p.country}";
  }
}

import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// TODO: Exposed API key! Hide in production
const googleApiKey = "AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI";

final googleMapsApiServicesProvider = Provider.autoDispose(
  (ref) => GoogleMapsApiServices(
    places: PlacesService.instance,
  ),
);

class GoogleMapsApiServices {
  GoogleMapsApiServices({required this.places});
  final PlacesService places;
}

class PlacesService {
  PlacesService._();
  static final instance = PlacesService._();

  Future<List<String?>> getAutocompleteSuggestions(String query) async {
    final googlePlace = GooglePlace(googleApiKey);
    final result = await googlePlace.autocomplete.get(query);
    final predictions = result?.predictions ?? [];
    return (predictions.isNotEmpty)
        ? predictions.map((p) => p.description).toList()
        : [];
  }
}

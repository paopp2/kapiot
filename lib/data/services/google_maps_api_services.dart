import 'package:google_place/google_place.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const googleApiKey = "AIzaSyDTfMR7hhsrr5ZQ6nLVUau4pCMcW7ChtiI";

final placesServiceProvider =
    Provider.autoDispose((ref) => PlacesService.instance);

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

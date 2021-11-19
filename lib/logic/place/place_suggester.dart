import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kapiot/data/services/google_maps_api_services.dart';
import 'package:kapiot/model/kapiot_location/kapiot_location.dart';

final placeSuggestionsProvider =
    StateProvider.autoDispose<List<String?>>((ref) => []);

final placeSuggesterProvider = Provider.autoDispose(
  (ref) => PlaceSuggester(read: ref.read),
);

class PlaceSuggester {
  PlaceSuggester({
    required this.read,
  });
  final Reader read;
  final _placesService = PlacesService.instance;

  /// Used to store all autocomplete suggestion Maps in order to obtain the "id"
  /// from "address"
  List<Map<String, String?>> _autocompleteSuggestionMaps = [];

  Future<KapiotLocation?> getLocation(String suggestedAddress) async {
    final pickedSuggestionMap = _autocompleteSuggestionMaps.firstWhere(
      (s) => s["address"] == suggestedAddress,
    );
    final placeId = pickedSuggestionMap["id"] as String;
    final location = await _placesService.getLocFromPlaceId(placeId);
    return location;
  }

  void updateSuggestions(String? value) async {
    final suggestions =
        await _placesService.getAutocompleteSuggestions(value ?? '');
    _autocompleteSuggestionMaps = suggestions;
    read(placeSuggestionsProvider.notifier).state =
        suggestions.map((s) => s["address"]).toList();
  }

  void clearSuggestions() {
    read(placeSuggestionsProvider.notifier).state = [];
  }
}

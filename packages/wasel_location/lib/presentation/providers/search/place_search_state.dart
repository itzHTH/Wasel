import 'package:wasel_location/domain/entities/place_suggestion.dart';

class PlaceSearchState {
  final List<PlaceSuggestion> suggestions;
  final String query;

  final bool isSearching;

  final Object? searchError;

  const PlaceSearchState({
    this.suggestions = const [],
    this.query = '',
    this.isSearching = false,
    this.searchError,
  });

  /// Distinguishes 'no matches' from 'nothing typed yet'.
  bool get isEmptyResult =>
      suggestions.isEmpty &&
      !isSearching &&
      searchError == null &&
      query.isNotEmpty;

  PlaceSearchState copyWith({
    List<PlaceSuggestion>? suggestions,
    String? query,
    bool? isSearching,
    Object? searchError,
    bool clearSearchError = false,
  }) {
    return PlaceSearchState(
      suggestions: suggestions ?? this.suggestions,
      query: query ?? this.query,
      isSearching: isSearching ?? this.isSearching,
      searchError: clearSearchError ? null : (searchError ?? this.searchError),
    );
  }
}

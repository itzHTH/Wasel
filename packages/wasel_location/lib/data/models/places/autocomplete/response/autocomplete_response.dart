import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasel_location/domain/entities/place_suggestion.dart';

part 'autocomplete_response.freezed.dart';
part 'autocomplete_response.g.dart';

// Google omits keys rather than sending nulls, so every field is nullable or
// defaulted.

@freezed
abstract class AutocompleteResponse with _$AutocompleteResponse {
  const factory AutocompleteResponse({
    @Default(<AutocompleteSuggestion>[])
    List<AutocompleteSuggestion> suggestions,
  }) = _AutocompleteResponse;

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteResponseFromJson(json);
}

@freezed
abstract class AutocompleteSuggestion with _$AutocompleteSuggestion {
  const factory AutocompleteSuggestion({PlacePrediction? placePrediction}) =
      _AutocompleteSuggestion;

  factory AutocompleteSuggestion.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteSuggestionFromJson(json);
}

@freezed
abstract class PlacePrediction with _$PlacePrediction {
  const factory PlacePrediction({
    String? placeId,
    PredictionText? text,
    StructuredFormat? structuredFormat,
  }) = _PlacePrediction;

  factory PlacePrediction.fromJson(Map<String, dynamic> json) =>
      _$PlacePredictionFromJson(json);
}

@freezed
abstract class StructuredFormat with _$StructuredFormat {
  const factory StructuredFormat({
    PredictionText? mainText,
    PredictionText? secondaryText,
  }) = _StructuredFormat;

  factory StructuredFormat.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormatFromJson(json);
}

@freezed
abstract class PredictionText with _$PredictionText {
  const factory PredictionText({String? text}) = _PredictionText;

  factory PredictionText.fromJson(Map<String, dynamic> json) =>
      _$PredictionTextFromJson(json);
}

String? _clean(String? value) {
  final trimmed = value?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}

/// Every result is Iraqi, so the trailing country only costs width.
const _countryNames = {'العراق', 'Iraq', 'عراق'};

/// Google returns the area pre-joined ('بغداد، العراق'). Splitting it back into
/// parts lets the UI join with the separator of the active language.
List<String> _areaParts(String? secondary, String name) {
  if (secondary == null) return const [];

  final parts = <String>[];
  for (final raw in secondary.split(RegExp('[،,]'))) {
    final part = _clean(raw);
    if (part == null || part == name) continue;
    if (_countryNames.contains(part) || parts.contains(part)) continue;
    parts.add(part);
  }
  return parts;
}

extension PlacePredictionX on PlacePrediction {
  /// Null when the prediction carries no id or no name — such a suggestion can
  /// be neither shown nor resolved to coordinates, so the caller drops it.
  PlaceSuggestion? toEntity() {
    final id = _clean(placeId);
    if (id == null) return null;

    final name = _clean(structuredFormat?.mainText?.text) ?? _clean(text?.text);
    if (name == null) return null;

    return PlaceSuggestion(
      id: id,
      name: name,
      addressParts: _areaParts(
        _clean(structuredFormat?.secondaryText?.text),
        name,
      ),
    );
  }
}

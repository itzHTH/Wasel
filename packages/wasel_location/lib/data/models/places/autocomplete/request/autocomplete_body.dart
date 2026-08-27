import 'package:freezed_annotation/freezed_annotation.dart';

part 'autocomplete_body.freezed.dart';
part 'autocomplete_body.g.dart';

@freezed
abstract class AutocompleteBody with _$AutocompleteBody {
  const factory AutocompleteBody({
    required String input,
    required String sessionToken,
    required String languageCode,
    required List<String> includedRegionCodes,
    @JsonKey(includeIfNull: false) AutocompleteLocationBias? locationBias,
  }) = _AutocompleteBody;

  factory AutocompleteBody.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteBodyFromJson(json);
}

@freezed
abstract class AutocompleteLocationBias with _$AutocompleteLocationBias {
  const factory AutocompleteLocationBias({required AutocompleteCircle circle}) =
      _AutocompleteLocationBias;

  factory AutocompleteLocationBias.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteLocationBiasFromJson(json);
}

@freezed
abstract class AutocompleteCircle with _$AutocompleteCircle {
  const factory AutocompleteCircle({
    required GoogleLatLng center,
    required double radius,
  }) = _AutocompleteCircle;

  factory AutocompleteCircle.fromJson(Map<String, dynamic> json) =>
      _$AutocompleteCircleFromJson(json);
}

@freezed
abstract class GoogleLatLng with _$GoogleLatLng {
  const factory GoogleLatLng({
    required double latitude,
    required double longitude,
  }) = _GoogleLatLng;

  factory GoogleLatLng.fromJson(Map<String, dynamic> json) =>
      _$GoogleLatLngFromJson(json);
}

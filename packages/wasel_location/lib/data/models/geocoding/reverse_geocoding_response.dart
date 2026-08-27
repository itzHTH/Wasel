import 'package:freezed_annotation/freezed_annotation.dart';

part 'reverse_geocoding_response.freezed.dart';
part 'reverse_geocoding_response.g.dart';

@freezed
abstract class ReverseGeocodingResponse with _$ReverseGeocodingResponse {
  const factory ReverseGeocodingResponse({
    @Default(<GeocodingResult>[]) List<GeocodingResult> results,
    String? status,
  }) = _ReverseGeocodingResponse;

  factory ReverseGeocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeocodingResponseFromJson(json);
}

@freezed
abstract class GeocodingResult with _$GeocodingResult {
  const factory GeocodingResult({
    @JsonKey(name: 'address_components')
    @Default(<AddressComponent>[])
    List<AddressComponent> addressComponents,
    @Default(<String>[]) List<String> types,
  }) = _GeocodingResult;

  factory GeocodingResult.fromJson(Map<String, dynamic> json) =>
      _$GeocodingResultFromJson(json);
}

@freezed
abstract class AddressComponent with _$AddressComponent {
  const factory AddressComponent({
    @JsonKey(name: 'long_name') String? longName,
    @Default(<String>[]) List<String> types,
  }) = _AddressComponent;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
}

String? _clean(String? value) {
  final trimmed = value?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}

const _streetTypes = {'route'};
const _areaTypes = {'sublocality_level_1', 'sublocality', 'neighborhood'};
const _cityTypes = {'locality', 'administrative_area_level_1'};

extension ReverseGeocodingResponseX on ReverseGeocodingResponse {
  /// The address parts, most specific first, with blanks dropped.
  List<String> toLabelParts() {
    String? firstOf(Set<String> wanted) {
      for (final result in results) {
        for (final component in result.addressComponents) {
          if (component.types.any(wanted.contains)) {
            final name = _clean(component.longName);
            if (name != null) return name;
          }
        }
      }
      return null;
    }

    final street = firstOf(_streetTypes) ?? firstOf(_areaTypes);
    final city = firstOf(_cityTypes);

    return [street, if (city != street) city].whereType<String>().toList();
  }
}

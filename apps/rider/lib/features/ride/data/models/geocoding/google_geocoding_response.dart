import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasal/features/ride/data/models/geocoding/address_component.dart';

part 'google_geocoding_response.g.dart';
part 'google_geocoding_response.freezed.dart';

@freezed
abstract class GoogleGeocodingResponse with _$GoogleGeocodingResponse {
  const factory GoogleGeocodingResponse({
    @Default(<GeocodeResult>[]) List<GeocodeResult> results,
  }) = _GoogleGeocodingResponse;

  factory GoogleGeocodingResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleGeocodingResponseFromJson(json);
}

@freezed
abstract class GeocodeResult with _$GeocodeResult {
  const factory GeocodeResult({
    @Default(<AddressComponent>[]) List<AddressComponent> addressComponents,
  }) = _GeocodeResult;

  factory GeocodeResult.fromJson(Map<String, dynamic> json) =>
      _$GeocodeResultFromJson(json);
}

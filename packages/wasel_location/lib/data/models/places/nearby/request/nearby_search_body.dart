import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wasel_location/data/models/places/autocomplete/request/autocomplete_body.dart';

part 'nearby_search_body.freezed.dart';
part 'nearby_search_body.g.dart';

@freezed
abstract class NearbySearchBody with _$NearbySearchBody {
  const factory NearbySearchBody({
    required String languageCode,
    required int maxResultCount,
    required String rankPreference,
    required NearbyLocationRestriction locationRestriction,
  }) = _NearbySearchBody;

  factory NearbySearchBody.fromJson(Map<String, dynamic> json) =>
      _$NearbySearchBodyFromJson(json);
}

@freezed
abstract class NearbyLocationRestriction with _$NearbyLocationRestriction {
  const factory NearbyLocationRestriction({required AutocompleteCircle circle}) =
      _NearbyLocationRestriction;

  factory NearbyLocationRestriction.fromJson(Map<String, dynamic> json) =>
      _$NearbyLocationRestrictionFromJson(json);
}

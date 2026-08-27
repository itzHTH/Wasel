import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_search_response.freezed.dart';
part 'nearby_search_response.g.dart';

@freezed
abstract class NearbySearchResponse with _$NearbySearchResponse {
  const factory NearbySearchResponse({
    @Default(<NearbyPlace>[]) List<NearbyPlace> places,
  }) = _NearbySearchResponse;

  factory NearbySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$NearbySearchResponseFromJson(json);
}

@freezed
abstract class NearbyPlace with _$NearbyPlace {
  const factory NearbyPlace({
    String? id,
    NearbyDisplayName? displayName,
    String? formattedAddress,
  }) = _NearbyPlace;

  factory NearbyPlace.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlaceFromJson(json);
}

@freezed
abstract class NearbyDisplayName with _$NearbyDisplayName {
  const factory NearbyDisplayName({String? text}) = _NearbyDisplayName;

  factory NearbyDisplayName.fromJson(Map<String, dynamic> json) =>
      _$NearbyDisplayNameFromJson(json);
}

String? _clean(String? value) {
  final trimmed = value?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}

const _countryNames = {'العراق', 'Iraq', 'عراق'};

/// Google falls back to an Open Location Code where it has no street name.
/// 'QJ2V+3GQ' names nothing a rider could point at, so it is dropped.
final _plusCode = RegExp(r'^[23456789CFGHJMPQRVWX]{4,8}\+[23456789CFGHJMPQRVWX]{2,}$');

extension NearbyPlaceX on NearbyPlace {
  /// The POI name, then the area that places it. Empty when the place has no
  /// name, which makes it useless as a label.
  List<String> toLabelParts() {
    final name = _clean(displayName?.text);
    if (name == null) return const [];

    final parts = [name];
    for (final raw in (_clean(formattedAddress) ?? '').split(RegExp('[،,]'))) {
      final part = _clean(raw);
      if (part == null || part == name) continue;
      if (_countryNames.contains(part) || _plusCode.hasMatch(part)) continue;
      if (parts.contains(part)) continue;
      parts.add(part);
      break;
    }
    return parts;
  }
}

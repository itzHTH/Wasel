import 'package:wasel_location/domain/entities/geo_point.dart';

/// One result of a place search.
class PlaceSuggestion {
  /// Opaque to everything above the data layer; the handle used to resolve
  /// point when the rider taps this result.
  final String id;

  /// The POI, street or area itself — the headline.
  final String name;

  /// What places name: neighbourhood, city, governorate, most specific
  /// first, with blanks and repeats dropped. May be empty.
  final List<String> addressParts;

  /// Null until resolved: autocomplete carries no coordinates, so a tapped
  /// suggestion is resolved through `BaseGeocodingRepo.retrievePlace`.
  final GeoPoint? point;

  const PlaceSuggestion({
    required this.id,
    required this.name,
    required this.addressParts,
    this.point,
  });

  //! Did'nt use freezed because we in domain layer , freezed is not pure dart and freezed is not supported in domain layer
  @override
  bool operator ==(Object other) =>
      other is PlaceSuggestion &&
      other.id == id &&
      other.name == name &&
      other.point == point &&
      _samePartsAs(other.addressParts);

  bool _samePartsAs(List<String> other) {
    if (identical(other, addressParts)) return true;
    if (other.length != addressParts.length) return false;
    for (var i = 0; i < other.length; i++) {
      if (other[i] != addressParts[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      Object.hash(id, name, Object.hashAll(addressParts), point);

  @override
  String toString() => 'PlaceSuggestion($id, $name, $addressParts, $point)';
}

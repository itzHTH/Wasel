class LocationApiConst {
  const LocationApiConst._();

  static const String placesAutocomplete = '/places:autocomplete';
  static const String placeDetails = '/places/{placeId}';
  static const String nearbySearch = '/places:searchNearby';
  static const String reverseGeocoding = '/json';

  static const String nearbyFieldMask =
      'places.id,places.displayName,places.formattedAddress,places.location';

  /// Tight enough that the result is somewhere the rider can point at.
  static const double nearbyRadiusMeters = 50;

  /// Ranking by distance returns whatever is nearest, which in Iraq is often an
  /// unlisted shopfront; ranking by popularity returns the landmark people
  /// actually name when arranging a pickup.
  static const String nearbyRankPreference = 'POPULARITY';

  /// Only the coordinates are billed for; Place Details prices by field group.
  static const String placeDetailsFieldMask = 'location';

  /// Used only when no active language is supplied.
  static const String geocodingFallbackLanguageCode = 'ar';

  static const String geocodingCountryCode = 'iq';

  static const String routesFieldMask = 'routes.polyline.encodedPolyline';
}

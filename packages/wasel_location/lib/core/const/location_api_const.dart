class LocationApiConst {
  const LocationApiConst._();

  static const String googleReverseGeocoding = '/geocode/location/{lat},{lng}';

  static const String geocodingFieldMask = 'results.addressComponents';

  /// Used only when no active language is supplied.
  static const String geocodingFallbackLanguageCode = 'ar';

  static const String geocodingRegionCode = 'IQ';

  static const String routesFieldMask = 'routes.polyline.encodedPolyline';

  static const String routeApiKeyName = 'ROUTES_API_KEY';
}

class LocationApiConst {
  const LocationApiConst._();

  static const String googleReverseGeocoding = '/geocode/location/{lat},{lng}';

  static const String geocodingFieldMask = 'results.addressComponents';

  static const String geocodingLanguageCode = 'ar';

  static const String geocodingRegionCode = 'IQ';

  static const String routesFieldMask = 'routes.polyline.encodedPolyline';

  static const String routeApiKeyName = 'ROUTES_API_KEY';
}

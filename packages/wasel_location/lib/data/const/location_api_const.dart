/// Endpoints and environment keys owned by this package.
///
/// These were duplicated across `ApiRiderEndpoints` and `DriverApiConsts`, one
/// copy per app, for calls into the same Google services. Centralising them here
/// means a change to the geocoding path or the key name can no longer be applied
/// to one app and forgotten in the other.
///
/// The Google base URL itself stays in `wasel_core`'s `ApiConstants`, alongside
/// the `googleDioFactory` that consumes it.
class LocationApiConst {
  const LocationApiConst._();

  /// Google Geocoding API v4 reverse lookup. `{lat}` / `{lng}` are filled by
  /// Retrofit via `@Path`.
  static const String googleReverseGeocoding = '/geocode/location/{lat},{lng}';

  /// Trims the response to the components the label parser reads. Anything
  /// wider is bandwidth billed for and then discarded.
  static const String geocodingFieldMask = 'results.addressComponents';

  /// Requests Arabic component spellings where Google has them.
  static const String geocodingLanguageCode = 'ar';

  /// Biases results to Iraq, the service area for both apps.
  static const String geocodingRegionCode = 'IQ';

  /// Restricts the Routes API response to the encoded polyline — the only part
  /// the map needs to draw a line.
  static const String routesFieldMask = 'routes.polyline.encodedPolyline';

  /// `.env` key holding the Google Routes API key.
  static const String routeApiKeyName = 'ROUTES_API_KEY';
}

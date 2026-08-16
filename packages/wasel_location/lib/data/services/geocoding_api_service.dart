import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:wasel_location/data/models/geocoding/google_geocoding_response.dart';

part 'geocoding_api_service.g.dart';

/// Google Geocoding API v4, reverse direction.
///
/// The Dio instance is supplied by `wasel_core`'s `googleDioFactory`, which
/// already carries the //? Google base URL and attaches the API key interceptor —
/// so no key is ever named here.
@RestApi()
abstract class GeocodingApiService {
  factory GeocodingApiService(Dio dio, {String? baseUrl}) =>
      _GeocodingApiService(dio, baseUrl: baseUrl);

  @Headers({'X-Goog-FieldMask': LocationApiConst.geocodingFieldMask})
  @GET(LocationApiConst.googleReverseGeocoding)
  Future<GoogleGeocodingResponse> getLocationName(
    @Path('lat') String lat,
    @Path('lng') String lng, {
    @Query('languageCode')
    String languageCode = LocationApiConst.geocodingLanguageCode,
    @Query('regionCode')
    String regionCode = LocationApiConst.geocodingRegionCode,
    @CancelRequest() CancelToken? cancelToken,
  });
}

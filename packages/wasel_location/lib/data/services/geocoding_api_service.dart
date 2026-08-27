import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:wasel_location/data/models/geocoding/reverse_geocoding_response.dart';

part 'geocoding_api_service.g.dart';

/// Google Geocoding. The key is attached by the interceptor.
@RestApi()
abstract class GeocodingApiService {
  @GET(LocationApiConst.reverseGeocoding)
  Future<ReverseGeocodingResponse> reverseGeocode({
    @Query('latlng') required String latlng,
    @Query('language')
    String language = LocationApiConst.geocodingFallbackLanguageCode,
    @CancelRequest() CancelToken? cancelToken,
  });

  factory GeocodingApiService(Dio dio, {String? baseUrl}) =>
      _GeocodingApiService(dio, baseUrl: baseUrl);
}

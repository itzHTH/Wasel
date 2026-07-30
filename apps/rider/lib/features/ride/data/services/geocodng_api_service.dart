import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/core/consts/api_rider_endpoints.dart';
import 'package:wasal/features/ride/data/models/geocoding/google_geocoding_response.dart';
import 'package:wasel_core/networking/dio/google_dio_factory.dart';

part 'geocodng_api_service.g.dart';

@RestApi()
abstract class GeocodngApiService {
  factory GeocodngApiService(Dio dio, {String? baseUrl}) =>
      _GeocodngApiService(dio, baseUrl: baseUrl);

  @Headers({'X-Goog-FieldMask': 'results.addressComponents'})
  @GET(ApiRiderEndpoints.googleReverseGeocoding)
  Future<GoogleGeocodingResponse> getLocationName(
    @Path("lat") String lat,
    @Path("lng") String lng, {
    @Query("languageCode") String languageCode = 'ar',
    @Query("regionCode") String regionCode = 'IQ',
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
GeocodngApiService geocodingApiService(Ref ref) {
  final dio = ref.watch(googleDioFactoryProvider);
  return GeocodngApiService(dio);
}

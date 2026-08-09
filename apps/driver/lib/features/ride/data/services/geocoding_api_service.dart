import 'package:dio/dio.dart' hide Headers;
import 'package:driver/core/const/driver_api_consts.dart';
import 'package:driver/features/ride/data/models/geocoding/google_geocoding_response.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/dio/google_dio_factory.dart';

part 'geocoding_api_service.g.dart';

@RestApi()
abstract class GeocodingApiService {
  factory GeocodingApiService(Dio dio, {String? baseUrl}) =>
      _GeocodingApiService(dio, baseUrl: baseUrl);

  /// The field mask keeps the response to the components we actually read —
  /// anything wider is bandwidth we pay for and then throw away.
  @Headers({'X-Goog-FieldMask': 'results.addressComponents'})
  @GET(DriverApiConsts.googleReverseGeocoding)
  Future<GoogleGeocodingResponse> getLocationName(
    @Path("lat") String lat,
    @Path("lng") String lng, {
    @Query("languageCode") String languageCode = 'ar',
    @Query("regionCode") String regionCode = 'IQ',
    @CancelRequest() CancelToken? cancelToken,
  });
}

@riverpod
GeocodingApiService geocodingApiService(Ref ref) {
  final dio = ref.watch(googleDioFactoryProvider);
  return GeocodingApiService(dio);
}

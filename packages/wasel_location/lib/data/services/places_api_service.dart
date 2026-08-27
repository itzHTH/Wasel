import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:wasel_location/core/const/location_api_const.dart';
import 'package:wasel_location/data/models/places/autocomplete/request/autocomplete_body.dart';
import 'package:wasel_location/data/models/places/autocomplete/response/autocomplete_response.dart';
import 'package:wasel_location/data/models/places/details/response/place_details_response.dart';
import 'package:wasel_location/data/models/places/nearby/request/nearby_search_body.dart';
import 'package:wasel_location/data/models/places/nearby/response/nearby_search_response.dart';

part 'places_api_service.g.dart';

/// Places API (New). The key is attached by the interceptor.
@RestApi()
abstract class PlacesApiService {
  factory PlacesApiService(Dio dio, {String? baseUrl}) =>
      _PlacesApiService(dio, baseUrl: baseUrl);

  @POST(LocationApiConst.placesAutocomplete)
  Future<AutocompleteResponse> autocomplete({
    @Body() required AutocompleteBody body,
    @CancelRequest() CancelToken? cancelToken,
  });

  @POST(LocationApiConst.nearbySearch)
  @Headers({'X-Goog-FieldMask': LocationApiConst.nearbyFieldMask})
  Future<NearbySearchResponse> searchNearby({
    @Body() required NearbySearchBody body,
    @CancelRequest() CancelToken? cancelToken,
  });

  /// The field mask is mandatory, and narrows what Google bills for.
  @GET(LocationApiConst.placeDetails)
  @Headers({'X-Goog-FieldMask': LocationApiConst.placeDetailsFieldMask})
  Future<PlaceDetailsResponse> placeDetails(
    @Path('placeId') String placeId, {
    @Query('sessionToken') required String sessionToken,
    @Query('languageCode')
    String languageCode = LocationApiConst.geocodingFallbackLanguageCode,
    @CancelRequest() CancelToken? cancelToken,
  });
}

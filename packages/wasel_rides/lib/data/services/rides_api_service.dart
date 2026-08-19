import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wasel_rides/core/const/rides_api_const.dart';
import 'package:wasel_rides/data/models/ride_history/response/ride_history_page_response.dart';

part 'rides_api_service.g.dart';

@RestApi()
abstract class RidesApiService {
  factory RidesApiService(Dio dio, {String? baseUrl}) =>
      _RidesApiService(dio, baseUrl: baseUrl);

  @GET(RidesApiConst.rideHistory)
  Future<RideHistoryPageResponse> getRideHistory({
    @Query('PageNumber') required int pageNumber,
    @Query('PageSize') required int pageSize,
    @CancelRequest() CancelToken? cancelToken,
  });
}

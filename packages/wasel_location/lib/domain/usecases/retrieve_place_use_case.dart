import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

class RetrievePlaceParams {
  const RetrievePlaceParams({required this.placeId, required this.languageCode});

  final String placeId;
  final String languageCode;
}

class RetrievePlaceUseCase
    extends CancellableUseCase<ApiResults<GeoPoint>, RetrievePlaceParams> {
  RetrievePlaceUseCase(this._geocodingRepo);

  final BaseGeocodingRepo _geocodingRepo;

  @override
  Future<ApiResults<GeoPoint>> execute(
    RetrievePlaceParams params,
    CancelToken cancelToken,
  ) {
    return _geocodingRepo.retrievePlace(
      params.placeId,
      languageCode: params.languageCode,
      cancelToken: cancelToken,
    );
  }
}

import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

/// The point to resolve, and the language to resolve it in.
class PointLabelParams {
  const PointLabelParams(this.point, this.languageCode);

  final GeoPoint point;
  final String languageCode;
}

class GetPointLabelUseCase
    extends CancellableUseCase<ApiResults<List<String>>, PointLabelParams> {
  GetPointLabelUseCase(this._geocodingRepo);

  final BaseGeocodingRepo _geocodingRepo;

  @override
  Future<ApiResults<List<String>>> execute(
    PointLabelParams params,
    CancelToken cancelToken,
  ) {
    return _geocodingRepo.labelFor(
      params.point,
      languageCode: params.languageCode,
      cancelToken: cancelToken,
    );
  }
}

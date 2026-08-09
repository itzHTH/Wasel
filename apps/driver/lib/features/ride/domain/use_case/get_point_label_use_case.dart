import 'package:dio/dio.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/domain/repos/geocoding_repo.dart';
import 'package:wasel_core/wasel_core.dart';

class GetPointLabelUseCase
    extends CancellableUseCase<ApiResults<String>, GeoPoint> {
  GetPointLabelUseCase(this._geocodingRepo);

  final BaseGeocodingRepo _geocodingRepo;

  @override
  Future<ApiResults<String>> execute(GeoPoint params, CancelToken cancelToken) {
    return _geocodingRepo.labelFor(params, cancelToken: cancelToken);
  }
}

import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/domain/repo/base_geocoding_repo.dart';
import 'package:wasel_core/usecase/base_use_case.dart';

class GetPointLabelUseCase extends BaseUseCase<String, GeoPoint> {
  final BaseGeocodingRepo _repo;

  GetPointLabelUseCase(this._repo);

  @override
  Future<String> call(GeoPoint params) => _repo.labelFor(params);
}

import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

/// Reverse-geocodes a point into a street/locality label.
///
/// Cancellable because the answer goes stale as fast as the user drags the pin:
/// each `call` mints a fresh token, so an in-flight lookup for an abandoned
/// point can be dropped rather than resolving late over a newer label.
class GetPointLabelUseCase
    extends CancellableUseCase<ApiResults<String>, GeoPoint> {
  GetPointLabelUseCase(this._geocodingRepo);

  final BaseGeocodingRepo _geocodingRepo;

  @override
  Future<ApiResults<String>> execute(GeoPoint params, CancelToken cancelToken) {
    return _geocodingRepo.labelFor(params, cancelToken: cancelToken);
  }
}

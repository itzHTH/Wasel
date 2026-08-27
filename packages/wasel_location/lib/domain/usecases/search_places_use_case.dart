import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/entities/place_suggestion.dart';
import 'package:wasel_location/domain/repos/base_geocoding_repo.dart';

class PlaceSearchParams {
  const PlaceSearchParams({
    required this.query,
    required this.languageCode,
    this.proximity,
  });

  final String query;
  final String languageCode;
  final GeoPoint? proximity;
}

class SearchPlacesUseCase
    extends
        CancellableUseCase<ApiResults<List<PlaceSuggestion>>, PlaceSearchParams> {
  SearchPlacesUseCase(this._geocodingRepo);

  final BaseGeocodingRepo _geocodingRepo;

  @override
  Future<ApiResults<List<PlaceSuggestion>>> execute(
    PlaceSearchParams params,
    CancelToken cancelToken,
  ) {
    return _geocodingRepo.searchPlaces(
      params.query,
      languageCode: params.languageCode,
      proximity: params.proximity,
      cancelToken: cancelToken,
    );
  }
}

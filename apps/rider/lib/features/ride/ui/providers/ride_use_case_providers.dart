import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/repo/fake_geocoding_repo.dart';
import 'package:wasal/features/ride/domain/repo/base_geocoding_repo.dart';
import 'package:wasal/features/ride/domain/usecases/get_point_label_use_case.dart';

part 'ride_use_case_providers.g.dart';

@riverpod
BaseGeocodingRepo geocodingRepo(Ref ref) => FakeGeocodingRepo();

@riverpod
GetPointLabelUseCase getPointLabelUseCase(Ref ref) {
  final geocodingRepo = ref.watch(geocodingRepoProvider);
  return GetPointLabelUseCase(geocodingRepo);
}

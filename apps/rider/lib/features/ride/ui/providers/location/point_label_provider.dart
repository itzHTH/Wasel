import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';

part 'point_label_provider.g.dart';

Duration? _retryLabelLookup(int retryCount, Object error) =>
    retryCount < 2 ? const Duration(milliseconds: 200) : null;

@Riverpod(keepAlive: true, retry: _retryLabelLookup)
Future<String> pointLabel(Ref ref, GeoPoint point) {
  final useCase = ref.watch(getPointLabelUseCaseProvider);
  return useCase(point);
}

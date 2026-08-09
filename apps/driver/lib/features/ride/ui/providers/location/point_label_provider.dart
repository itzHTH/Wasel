import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/ui/providers/ride_use_case_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'point_label_provider.g.dart';

Duration? _retryLabelLookup(int retryCount, Object error) =>
    retryCount < 2 ? const Duration(milliseconds: 200) : null;

@Riverpod(keepAlive: true, retry: _retryLabelLookup)
Future<String> pointLabel(Ref ref, GeoPoint point) async {
  final useCase = ref.watch(getPointLabelUseCaseProvider);
  final result = await useCase(point);

  return result.when(
    success: (label) => label,
    failure: (error) => throw error,
  );
}

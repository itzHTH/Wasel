import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';

part 'point_label_provider.g.dart';

@Riverpod(keepAlive: true)
Future<String> pointLabel(Ref ref, GeoPoint point) {
  final useCase = ref.watch(getPointLabelUseCaseProvider);
  return useCase(point);
}

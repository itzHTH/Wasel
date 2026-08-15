import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';

part 'point_label_provider.g.dart';

/// Retries transient network failures twice (200ms apart) to recover
/// cosmetic labels without noticeable UI disruption, capped at 2 to limit API billing.
Duration? _retryLabelLookup(int retryCount, Object error) =>
    retryCount < 2 ? const Duration(milliseconds: 200) : null;

/// Resolves a GeoPoint into a localized 'street، locality' label.
///
//? - Uses GeoPoint as the cache key: structurally identical points resolve
//?   instantly from memory instead of triggering duplicate Google API billing.
//
//? - Kept alive (`keepAlive: true`) so scrolled UI elements (like address rows)
//?  do not repeatedly fetch the same label when remounted.
//
//? - Unwraps ApiResults and explicitly `throw`s failures. This bridges the
//?   domain layer with Riverpod's [AsyncValue] and is required to trigger the `@Riverpod(retry: ...)` hook.
@Riverpod(keepAlive: true, retry: _retryLabelLookup)
Future<String> pointLabel(Ref ref, GeoPoint point) async {
  final result = await ref.watch(getPointLabelUseCaseProvider).call(point);

  return result.when(
    success: (label) => label,
    failure: (error) => throw error,
  );
}

import 'package:wasel_location/domain/usecases/get_point_label_use_case.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_location/l10n/location_l10n_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';

part 'point_label_provider.g.dart';

/// Retries transient network failures twice (200ms apart) to recover
/// cosmetic labels without noticeable UI disruption, capped at 2 to limit API billing.
Duration? _retryLabelLookup(int retryCount, Object error) =>
    retryCount < 2 ? const Duration(milliseconds: 200) : null;

/// Resolves a GeoPoint into a localized 'street, locality' label.
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
  // Watched, not read: switching language re-resolves every cached label,
  // which would otherwise stay in the language it was first fetched in.
  final locale = ref.watch(appLocalizationControllerProvider);

  final result = await ref
      .watch(getPointLabelUseCaseProvider)
      .call(PointLabelParams(point, locale.languageCode));

  return result.when(
    // Empty, not a placeholder: a point Google cannot name is reported as an
    // empty label so callers fall back to their coordinates, which at least
    // tell two nameless points apart.
    success: (parts) => parts.join(locationL10nNow.addressSeparator),
    failure: (error) => throw error,
  );
}

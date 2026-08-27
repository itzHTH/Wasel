import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/l10n/location_l10n_extension.dart';
import 'package:wasel_location/presentation/providers/location/last_known_location_provider.dart';
import 'package:wasel_location/presentation/providers/location/point_label_provider.dart';

part 'current_location_label_provider.g.dart';

Duration? _noRetry(int retryCount, Object error) => null;

/// A human-readable name for where the rider is standing, for pre-filling a
/// pickup field.
@Riverpod(retry: _noRetry)
Future<String> currentLocationLabel(Ref ref) async {
  final fallback = locationL10nNow.currentLocation;

  try {
    //! Inside the try: a denied permission or an unavailable sensor throws
    //! here, and letting that escape would surface an error in the field.
    final point = await ref.watch(lastKnownLocationProvider.future);
    if (point == null) return fallback;

    final label = await ref.watch(pointLabelProvider(point).future);
    return label.isEmpty ? fallback : label;
  } catch (_) {
    return fallback;
  }
}

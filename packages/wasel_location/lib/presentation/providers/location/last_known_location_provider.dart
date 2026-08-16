import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';

part 'last_known_location_provider.g.dart';

/// Fetches the last known OS location cache as a one-shot read.
//
//? - Uses [FutureProvider] because this is a single, immediate cache lookup.
//
//? - Kept alive (`keepAlive: true`) in memory for the session to prevent
//?   micro-stutters when the map screen is remounted.
//
//? - Errors are intentionally swallowed by the repository and yield `null`,
//?  allowing the UI to smoothly fallback to a default camera target.
@Riverpod(keepAlive: true)
Future<GeoPoint?> lastKnownLocation(Ref ref) async {
  final fix = await ref.watch(getLastKnownLocationUseCaseProvider).call(null);
  return fix?.point;
}

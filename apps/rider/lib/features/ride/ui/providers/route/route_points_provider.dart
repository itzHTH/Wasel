import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_location/wasel_location.dart';

part 'route_points_provider.g.dart';

/// The drawn route between the draft's pickup and dropoff.
@riverpod
Future<List<GeoPoint>> routePoints(Ref ref) async {
  final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
  final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));
  if (pickup == null || dropoff == null) return const [];

  final useCase = ref.watch(getRouteUseCaseProvider);
  final result = await useCase(
    RouteRequest(
      origin: GeoPoint(latitude: pickup.latitude, longitude: pickup.longitude),
      destination: GeoPoint(
        latitude: dropoff.latitude,
        longitude: dropoff.longitude,
      ),
    ),
  );

  return result.when(success: (points) => points, failure: (_) => const []);
}

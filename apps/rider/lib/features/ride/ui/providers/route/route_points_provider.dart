import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/data/models/geo_point_request/geo_point_request_body.dart';
import 'package:wasal/features/ride/domain/entities/geo_point.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_use_case_providers.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'route_points_provider.g.dart';

@riverpod
Future<List<GeoPoint>> routePoints(Ref ref) async {
  final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
  final dropoff = ref.watch(rideDraftProvider.select((s) => s.dropoff));
  if (pickup == null || dropoff == null) return const [];

  final useCase = ref.watch(getRouteUseCaseProvider);
  final result = await useCase(
    GeoPointRequestBody(
      pickupLat: pickup.latitude.toString(),
      pickupLng: pickup.longitude.toString(),
      dropoffLat: dropoff.latitude.toString(),
      dropoffLng: dropoff.longitude.toString(),
    ),
  );

  return result.when(success: (points) => points, failure: (_) => const []);
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/route/route_points_provider.dart';
import 'package:wasel_core/wasel_core.dart';

part 'route_polylines_provider.g.dart';

@riverpod
Set<Polyline> routePolylines(Ref ref) {
  final points = ref.watch(routePointsProvider).value ?? const [];
  if (points.length < 2) return const {};

  return {
    Polyline(
      polylineId: const PolylineId('active_route'),
      points: points.map((p) => LatLng(p.latitude, p.longitude)).toList(),
      color: AppColor.primary500,
      width: 4,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    ),
  };
}

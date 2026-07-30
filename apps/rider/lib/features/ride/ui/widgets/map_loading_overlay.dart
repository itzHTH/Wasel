import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/map/map_ready_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/route/route_points_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class MapLoadingOverlay extends ConsumerWidget {
  const MapLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapReady = ref.watch(mapReadyProvider);
    if (!mapReady) return const AppLoadingOverlay();

    final hasBothPoints = ref.watch(
      rideDraftProvider.select((s) => s.pickup != null && s.dropoff != null),
    );
    final routeLoading =
        hasBothPoints &&
        ref.watch(routePointsProvider.select((s) => s.isLoading));
    if (!routeLoading) return const SizedBox.shrink();

    return AppLoadingOverlay(
      backgroundColor: AppColor.secondary900.withValues(alpha: 0.25),
    );
  }
}

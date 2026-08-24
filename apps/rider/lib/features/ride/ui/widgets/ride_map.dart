import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/features/ride/ui/animation/search_radius_motion.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_point_markers_provider.dart';
import 'package:wasal/features/ride/ui/providers/route/route_polylines_provider.dart';
import 'package:wasal/features/ride/ui/providers/tracking/driver_car_motion_provider.dart';
import 'package:wasal/features/ride/ui/providers/tracking/search_radius_motion_provider.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/wasel_location.dart';

class RideMap extends ConsumerWidget {
  const RideMap({
    super.key,
    this.onCameraMove,
    this.onCameraMoveStarted,
    this.onCameraIdle,
    this.mapPadding = EdgeInsets.zero,
  });

  final ValueChanged<CameraPosition>? onCameraMove;
  final VoidCallback? onCameraMoveStarted;
  final VoidCallback? onCameraIdle;

  final EdgeInsets mapPadding;

  /// Opacity floor and swing of the pulsing search radius.
  static const _fillAlpha = 0.08;
  static const _strokeAlpha = 0.4;
  static const _fillPulseSwing = 0.05;
  static const _strokePulseSwing = 0.25;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pins = ref.watch(ridePointMarkersProvider);
    final polylines = ref.watch(routePolylinesProvider);
    final motion = ref.watch(driverCarMotionProvider);
    final radius = ref.watch(searchRadiusMotionProvider);
    final pickup = ref.watch(rideDraftProvider.select((s) => s.pickup));
    final carIcon = ref.watch(mapMarkerIconProvider(AppIcons.car)).value;
    final palette = ref.watch(appPaletteProvider);

    // Both animators glide on their own tickers; merging them keeps the map to
    // a single rebuilding subtree instead of one per animation.
    return AnimatedBuilder(
      animation: Listenable.merge([motion, radius]),
      builder: (context, _) => AppMap(
        markers: {
          ...pins,
          if (motion.hasFix) motion.value.toMarker(icon: carIcon),
        },
        polylines: polylines,
        circles: _circles(radius, pickup, palette),
        padding: mapPadding,
        onCameraMove: onCameraMove,
        onCameraMoveStarted: onCameraMoveStarted,
        onCameraIdle: onCameraIdle,
      ),
    );
  }

  Set<Circle> _circles(
    SearchRadiusMotion radius,
    LatLng? pickup,
    AppColorsExtension palette,
  ) {
    if (!radius.isRunning || pickup == null) return const {};

    final pulse = radius.pulse;

    return {
      Circle(
        circleId: const CircleId('search_radius'),
        center: pickup,
        radius: radius.radiusMeters,
        fillColor: palette.primary500.withValues(
          alpha: _fillAlpha + _fillPulseSwing * pulse,
        ),
        strokeColor: palette.primary500.withValues(
          alpha: _strokeAlpha + _strokePulseSwing * pulse,
        ),
        strokeWidth: 1,
      ),
    };
  }
}

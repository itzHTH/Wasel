import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/ui/providers/map/driver_camera_controller.dart';
import 'package:driver/features/ride/ui/providers/map/driver_car_motion_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_is_camera_moving_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_route_polylines_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_location/wasel_location.dart';

class DriverRideMap extends ConsumerWidget {
  const DriverRideMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markers = ref.watch(driverMarkersProvider);
    final polylines = ref.watch(driverRoutePolylinesProvider).value ?? const {};
    final motion = ref.watch(driverCarMotionProvider);
    final carIcon = ref
        .watch(mapMarkerIconProvider(AppDriverConsts.carIcon))
        .value;

    return AnimatedBuilder(
      animation: motion,
      builder: (context, _) => AppMap(
        // The animated car marker already shows where the driver is; the
        // native blue dot underneath it reads as a second vehicle.
        myLocationEnabled: false,
        markers: {
          ...markers,
          if (motion.hasFix) motion.value.toMarker(icon: carIcon),
        },
        polylines: polylines,
        onCameraMoveStarted: () {
          final movedByDriver = ref
              .read(driverCameraControllerProvider.notifier)
              .onMoveStarted();

          if (!movedByDriver) return;

          ref.read(driverIsCameraMovingProvider.notifier).setMoving(true);
        },
        onCameraIdle: () {
          ref.read(driverCameraControllerProvider.notifier).onIdle();
          ref.read(driverIsCameraMovingProvider.notifier).setMoving(false);
        },
      ),
    );
  }
}

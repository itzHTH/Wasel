import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/ui/providers/earnings/driver_balance_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_camera_controller.dart';
import 'package:driver/features/ride/ui/providers/map/driver_is_camera_moving_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_location_broadcaster.dart';
import 'package:driver/features/ride/ui/providers/location/initial_camera_target_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_route_polylines_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/widgets/driver_ride_cards_switcher.dart';
import 'package:driver/features/ride/ui/widgets/status/driver_status_bar.dart';
import 'package:driver/features/ride/ui/widgets/my_location_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key});

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
  @override
  initState() {
    super.initState();
    ref.read(driverBalanceControllerProvider.notifier).getDriverBalance();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(rideActionControllerProvider, (previous, next) {
      if (!next.hasError) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(next.error.toString())));
    });

    ref.watch(driverLocationBroadcasterProvider);
    ref.watch(driverCameraControllerProvider);

    final markers = ref.watch(driverMarkersProvider);
    final initialTarget = ref.watch(initialCameraTargetProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (initialTarget.hasValue)
            AppMap(
              mapId: AppDriverConsts.mapStyleID,
              initialTarget: initialTarget.requireValue,
              markers: markers,
              polylines:
                  ref.watch(driverRoutePolylinesProvider).value ?? const {},
              onCameraMoveStarted: () {
                final movedByDriver = ref
                    .read(driverCameraControllerProvider.notifier)
                    .onMoveStarted();

                // Following the driver repaints the camera constantly; only a
                // real gesture should collapse an expanded card.
                if (!movedByDriver) return;

                ref.read(driverIsCameraMovingProvider.notifier).setMoving(true);
              },
              onCameraIdle: () {
                ref.read(driverCameraControllerProvider.notifier).onIdle();
                ref
                    .read(driverIsCameraMovingProvider.notifier)
                    .setMoving(false);
              },
            ),
          const Positioned.fill(child: AppMapLoadingOverlay()),
          Positioned(
            top: AppDimens.space16,
            child: const SafeArea(child: DriverStatusBar()),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: AppDimens.space16,
                    right: AppDimens.screenHPadding,
                    bottom: AppDimens.space16,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: MyLocationButton(),
                  ),
                ),
                const DriverRideCardsSwitcher(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

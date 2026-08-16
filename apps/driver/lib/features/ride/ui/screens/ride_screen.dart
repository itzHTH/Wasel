import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/ride/ui/providers/map/driver_camera_controller.dart';
import 'package:driver/features/ride/ui/providers/map/driver_is_camera_moving_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_location_broadcaster.dart';
import 'package:driver/features/ride/ui/providers/map/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_route_polylines_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/widgets/driver_ride_cards_switcher.dart';
import 'package:driver/features/ride/ui/widgets/status/driver_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/wasel_location.dart';

class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key});

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
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

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // The opening camera is resolved inside AppMap now, which also holds
          // the platform view back until it lands — the gate that used to sit
          // here.
          AppMap(
            mapId: AppDriverConsts.mapStyleID,
            markers: markers,
            polylines:
                ref.watch(driverRoutePolylinesProvider).value ?? const {},
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
          const Positioned.fill(child: AppMapLoadingOverlay()),
          PositionedDirectional(
            top: AppDimens.space16,
            start: AppDimens.space16,
            end: AppDimens.space16,
            child: SafeArea(
              child: Row(
                children: [
                  AppMapProfileButton(
                    heroTag: 'driver_profile_button',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.profile),
                  ),
                  SizedBox(width: AppDimens.space8),
                  const Flexible(child: Align(child: DriverStatusBar())),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: AppDimens.screenHPadding,
                    end: AppDimens.space16,
                    bottom: AppDimens.space16,
                  ),
                  child: const Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: MyLocationButton(
                      heroTag: 'driver_my_location_button',
                      zoom: 17,
                    ),
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

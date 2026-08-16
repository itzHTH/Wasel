import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_location_controller.dart';
import 'package:wasal/features/ride/ui/providers/tracking/ride_camera_controller.dart';
import 'package:wasal/features/ride/ui/widgets/custom_pin_map.dart';
import 'package:wasal/features/ride/ui/widgets/location_permission_banner.dart';
import 'package:wasal/features/ride/ui/widgets/my_location_button.dart';
import 'package:wasal/features/ride/ui/widgets/ride_cards_switcher.dart';
import 'package:wasal/features/ride/ui/widgets/ride_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/core/const/app_map_defaults.dart';
import 'package:wasel_location/presentation/widgets/app_map_loading_overlay.dart';

class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key});

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
  LatLng _center = AppMapDefaults.initialTarget;

  void _centerOnUserLocation() {
    ref
        .read(rideLocationControllerProvider.notifier)
        .centerOnUserLocation(context);
  }

  @override
  void initState() {
    super.initState();
    _centerOnUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(rideCameraControllerProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          RideMap(
            mapPadding: EdgeInsets.zero,
            onCameraMove: (position) => _center = position.target,
            onCameraMoveStarted: () =>
                ref.read(isCameraMovingProvider.notifier).setMoving(true),
            onCameraIdle: () =>
                ref.read(isCameraMovingProvider.notifier).setMoving(false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: AppDimens.space48),
            child: CustomPinMap(),
          ),
          const Positioned.fill(child: AppMapLoadingOverlay()),
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
                    alignment: AlignmentDirectional.centerEnd,
                    child: MyLocationButton(),
                  ),
                ),
                const LocationPermissionBanner(),
                RideCardsSwitcher(
                  onConfirm: () => ref
                      .read(rideDraftProvider.notifier)
                      .confirmCurrentPoint(_center),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

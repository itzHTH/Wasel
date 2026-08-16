import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/core/routing/app_routes_name.dart';
import 'package:wasal/features/ride/ui/providers/tracking/ride_camera_controller.dart';
import 'package:wasal/features/ride/ui/widgets/custom_pin_map.dart';
import 'package:wasal/features/ride/ui/widgets/ride_cards_switcher.dart';
import 'package:wasal/features/ride/ui/widgets/ride_map.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:wasel_location/wasel_location.dart';

class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key});

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
  LatLng _center = AppMapDefaults.initialTarget;

  void _centerOnUserLocation() {
    ref.read(recenterControllerProvider.notifier).centerOnUser(context);
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
          PositionedDirectional(
            top: AppDimens.space16,
            start: AppDimens.space16,
            child: SafeArea(
              child: AppMapProfileButton(
                heroTag: 'rider_profile_button',
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.profile),
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_location_controller.dart';
import 'package:wasal/features/ride/ui/widgets/custom_map.dart';
import 'package:wasal/features/ride/ui/widgets/custom_pin_map.dart';
import 'package:wasal/features/ride/ui/widgets/ride_bottom_card.dart';
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key});

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // Latest camera target; updated tens of times per second while the camera
  // moves, so it must stay a plain field — never provider/setState-backed.
  LatLng _center = CustomMap.initialTarget;
  void _centerOnUserLocation() {
    ref
        .read(rideLocationControllerProvider)
        .centerOnUserLocation(context, _mapController);
  }

  @override
  void initState() {
    super.initState();
    _centerOnUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomMap(
              controller: _mapController,
              onCameraMove: (position) => _center = position.target,
              onCameraMoveStarted: () => ref
                  .read(isCameraMovingProvider.notifier)
                  .setMoving(true),
              onCameraIdle: () =>
                  ref.read(isCameraMovingProvider.notifier).setMoving(false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppDimens.space48),
              child: CustomPinMap(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: AppDimens.screenHPadding,
                      bottom: AppDimens.space16,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: FloatingActionButton.small(
                        backgroundColor: AppColor.neutral0,
                        shape: const CircleBorder(),
                        onPressed: _centerOnUserLocation,
                        child: const Icon(
                          Icons.my_location,
                          color: AppColor.primary500,
                        ),
                      ),
                    ),
                  ),
                  RideBottomCard(
                    onConfirm: () => ref
                        .read(rideDraftProvider.notifier)
                        .confirmCurrentPoint(_center),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

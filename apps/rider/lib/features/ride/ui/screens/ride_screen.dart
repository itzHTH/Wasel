import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasal/features/ride/ui/widgets/custom_map.dart';
import 'package:wasal/features/ride/ui/widgets/custom_pin_map.dart';
import 'package:wasal/features/ride/ui/widgets/ride_bottom_card.dart';
import 'package:wasel_core/permissions/permission_gate.dart' as permission_gate;
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
  Future<bool> _requestLocationPermission() async {
    return permission_gate.ensurePermission(
      context,
      Permission.location,
      deniedTitle: 'إذن الموقع مطلوب',
      deniedMessage: 'يرجى تمكين إذن الموقع للوصول إلى هذه الميزة.',
    );
  }

  Future<void> _goToCurrentLocation() async {
    final granted = await _requestLocationPermission();
    if (!granted) return;

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      final controller = await _mapController.future;
      if (!mounted) return;
      await controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (_) {
      // Location unavailable (services off / timeout) — keep the current view.
    }
  }

  @override
  void initState() {
    super.initState();
    _goToCurrentLocation();
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
                      child: FloatingActionButton(
                        backgroundColor: AppColor.primary500,
                        shape: const CircleBorder(),
                        onPressed: _goToCurrentLocation,
                        child: const Icon(
                          Icons.location_searching,
                          color: AppColor.secondary300,
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

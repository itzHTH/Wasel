import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasal/features/ride/ui/widgets/custom_map.dart';
import 'package:wasal/features/ride/ui/widgets/custom_pin_map.dart';
import 'package:wasel_core/permissions/permission_gate.dart' as permission_gate;
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary500,
        shape: const CircleBorder(),
        onPressed: _goToCurrentLocation,
        child: const Icon(
          Icons.location_searching,
          color: AppColor.secondary300,
        ),
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomMap(controller: _mapController),
            Padding(
              padding: EdgeInsets.only(bottom: AppDimens.space48),
              child: CustomPinMap(),
            ),
          ],
        ),
      ),
    );
  }
}

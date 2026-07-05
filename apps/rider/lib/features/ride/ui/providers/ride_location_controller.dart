import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/permissions/permission_gate.dart' as permission_gate;

part 'ride_location_controller.g.dart';

/// Owns the "center the map on the user" flow so the screen only forwards
/// the tap: permission gate → location service check → position → camera.
class RideLocationController {
  const RideLocationController();

  Future<void> centerOnUserLocation(
    BuildContext context,
    Completer<GoogleMapController> mapController,
  ) async {
    final granted = await permission_gate.ensurePermission(
      context,
      Permission.location,
      deniedTitle: 'إذن الموقع مطلوب',
      deniedMessage: 'يرجى تمكين إذن الموقع للوصول إلى هذه الميزة.',
    );
    if (!context.mounted) return;
    if (!granted) {
      final status = await Permission.location.status;
      if (!context.mounted) return;
      // Permanently denied/restricted already got the gate's settings dialog.
      if (!status.isPermanentlyDenied && !status.isRestricted) {
        _showSnackBar(context, 'ما نگدر نوصل لموقعك بدون إذن الموقع');
      }
      return;
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!context.mounted) return;
    if (!serviceEnabled) {
      _showSnackBar(
        context,
        'خدمة الموقع مطفّية، شغّلها حتى نگدر نوصل لموقعك',
        actionLabel: 'الإعدادات',
        onAction: () => Geolocator.openLocationSettings(),
      );
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      final controller = await mapController.future;
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          16,
        ),
      );
    } catch (_) {
      // Location unavailable (services toggled off mid-flow / timeout) —
      // keep the current view.
    }
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: actionLabel == null || onAction == null
            ? null
            : SnackBarAction(label: actionLabel, onPressed: onAction),
      ),
    );
  }
}

@riverpod
RideLocationController rideLocationController(Ref ref) =>
    const RideLocationController();

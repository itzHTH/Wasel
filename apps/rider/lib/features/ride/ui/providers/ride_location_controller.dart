import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/location/location_permission_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_location_state.dart';
import 'package:wasel_location/presentation/providers/map/map_controller_provider.dart';

part 'ride_location_controller.g.dart';

@riverpod
class RideLocationController extends _$RideLocationController {
  static const _fixTimeout = Duration(seconds: 15);

  @override
  RideLocationState build() => const RideLocationState();

  Future<void> centerOnUserLocation(BuildContext context) async {
    if (state.isLocating) return;

    final access = await ref
        .read(locationPermissionProvider.notifier)
        .request(context);
    if (!context.mounted) return;
    if (access != LocationAccess.granted) {
      final status = await Permission.location.status;
      if (!context.mounted) return;
      if (!status.isPermanentlyDenied && !status.isRestricted) {
        _showSnackBar(context, 'ما نگدر نوصل لموقعك بدون إذن الموقع');
      }
      return;
    }

    if (ref.mounted) {
      state = state.copyWith(myLocationEnabled: true, isLocating: true);
    }

    try {
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

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: _fixTimeout,
        ),
      );
      final controller = await ref.read(mapControllerHolderProvider.future);
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          16,
        ),
      );
    } on TimeoutException {
      if (!context.mounted) return;
      _showSnackBar(context, 'ما گدرنا نلگه موقعك، جرّب مرة ثانية');
    } catch (_) {
      if (!context.mounted) return;
      _showSnackBar(context, 'صار خطأ وإحنا ندوّر على موقعك');
    } finally {
      if (ref.mounted) state = state.copyWith(isLocating: false);
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

import 'package:driver/features/ride/ui/providers/device_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wasel_core/wasel_core.dart';

/// Recentres the map on the driver.
///
/// Deliberately simpler than the rider's button of the same name: the driver
/// app is already streaming positions through [deviceLocationProvider] by the
/// time this is on screen, so there is no permission prompt or fix-timeout to
/// handle — it just flies the camera to the latest fix.
class MyLocationButton extends ConsumerWidget {
  const MyLocationButton({super.key});

  static const _zoom = 17.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(deviceLocationProvider);

    return FloatingActionButton.small(
      heroTag: 'driver_my_location_button',
      backgroundColor: AppColor.neutral0,
      shape: const CircleBorder(),
      onPressed: location.hasValue
          ? () => _centre(ref, location.requireValue)
          : null,
      child: location.isLoading
          ? AppInlineLoading(size: AppDimens.icon20)
          : Icon(
              Icons.my_location,
              size: AppDimens.icon20,
              color: location.hasValue
                  ? AppColor.primary500
                  : AppColor.neutral400,
            ),
    );
  }

  Future<void> _centre(WidgetRef ref, Position position) async {
    final controller = await ref.read(mapControllerHolderProvider.future);
    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        _zoom,
      ),
    );
  }
}

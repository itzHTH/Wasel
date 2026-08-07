import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/ui/providers/driver_camera_controller.dart';
import 'package:driver/features/ride/ui/providers/driver_location_broadcaster.dart';
import 'package:driver/features/ride/ui/providers/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/driver_route_polylines_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/driver_cards_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends ConsumerWidget {
  const RideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(rideActionControllerProvider, (previous, next) {
      if (!next.hasError) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(next.error.toString())));
    });

    ref.watch(driverLocationBroadcasterProvider);
    ref.watch(driverCameraControllerProvider);

    final markers = ref.watch(driverMarkersProvider);

    final isOnline = ref.watch(
      rideControllerProvider.select(
        (state) => state.stage != DriverStage.offline,
      ),
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppMap(
            mapId: AppDriverConsts.mapStyleID,
            markers: markers,
            polylines:
                ref.watch(driverRoutePolylinesProvider).value ?? const {},
            onCameraMoveStarted: () => ref
                .read(driverCameraControllerProvider.notifier)
                .onMoveStarted(),
            onCameraIdle: () =>
                ref.read(driverCameraControllerProvider.notifier).onIdle(),
          ),
          const Positioned.fill(child: AppMapLoadingOverlay()),
          Positioned(
            top: AppDimens.space16,
            child: SafeArea(
              child: _OnlineToggleCard(
                isOnline: isOnline,
                onChanged: (value) => value
                    ? ref.read(rideControllerProvider.notifier).goOnline()
                    : ref.read(rideControllerProvider.notifier).goOffline(),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: DriverCardsSwitcher(),
          ),
        ],
      ),
    );
  }
}

class _OnlineToggleCard extends StatelessWidget {
  const _OnlineToggleCard({required this.isOnline, required this.onChanged});

  final bool isOnline;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.elementBackground,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.space16,
          vertical: AppDimens.space8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isOnline ? 'متصل' : 'غير متصل',
              style: AppTextStyles.font14Secondary900SemiBold,
            ),
            SizedBox(width: AppDimens.space8),
            Switch(
              value: isOnline,
              activeTrackColor: AppColor.primary500,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

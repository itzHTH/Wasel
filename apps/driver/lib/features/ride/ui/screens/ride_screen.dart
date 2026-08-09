import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/features/ride/domain/entities/geo_point.dart';
import 'package:driver/features/ride/ui/providers/earnings/driver_balance_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_camera_controller.dart';
import 'package:driver/features/ride/ui/providers/map/driver_is_camera_moving_provider.dart';
import 'package:driver/features/ride/ui/providers/location/driver_location_broadcaster.dart';
import 'package:driver/features/ride/ui/providers/map/driver_markers_provider.dart';
import 'package:driver/features/ride/ui/providers/map/driver_route_polylines_provider.dart';
import 'package:driver/features/ride/ui/providers/navigation/navigation_handoff_provider.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:driver/features/ride/ui/widgets/driver_ride_cards_switcher.dart';
import 'package:driver/features/ride/ui/widgets/status/driver_status_bar.dart';
import 'package:driver/features/ride/ui/widgets/my_location_button.dart';
import 'package:driver/features/ride/ui/widgets/navigation/navigation_chooser_sheet.dart';
import 'package:driver/features/ride/ui/widgets/navigation/navigation_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends ConsumerStatefulWidget {
  const RideScreen({super.key});

  @override
  ConsumerState<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends ConsumerState<RideScreen> {
  @override
  initState() {
    super.initState();
    ref.read(driverBalanceControllerProvider.notifier).getDriverBalance();
  }

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
          AppMap(
            mapId: AppDriverConsts.mapStyleID,
            markers: markers,
            polylines:
                ref.watch(driverRoutePolylinesProvider).value ?? const {},
            onCameraMoveStarted: () {
              final movedByDriver = ref
                  .read(driverCameraControllerProvider.notifier)
                  .onMoveStarted();

              // Following the driver repaints the camera constantly; only a
              // real gesture should collapse an expanded card.
              if (!movedByDriver) return;

              ref.read(driverIsCameraMovingProvider.notifier).setMoving(true);
            },
            onCameraIdle: () {
              ref.read(driverCameraControllerProvider.notifier).onIdle();
              ref.read(driverIsCameraMovingProvider.notifier).setMoving(false);
            },
          ),
          const Positioned.fill(child: AppMapLoadingOverlay()),
          Positioned(
            top: AppDimens.space16,
            child: const SafeArea(child: DriverStatusBar()),
          ),
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
                    alignment: AlignmentDirectional.centerStart,
                    child: _MapControls(),
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

/// Navigation hand-off sits above the recentre button, and only while there is
/// somewhere to navigate to.
class _MapControls extends ConsumerWidget {
  const _MapControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(rideControllerProvider.select(_navigationTarget));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (target != null) ...[
          NavigationFab(onTap: () => _navigateTo(context, ref, target)),
          SizedBox(height: AppDimens.space12),
        ],
        const MyLocationButton(),
      ],
    );
  }
}

/// Where the driver is headed for the current stage, or null when the stage
/// has no destination worth navigating to.
GeoPoint? _navigationTarget(DriverRideState state) {
  final ride = state.ride;
  if (ride == null) return null;

  return switch (state.stage) {
    DriverStage.heading => ride.position,
    DriverStage.inProgress => ride.dropPosition,
    _ => null,
  };
}

Future<void> _navigateTo(
  BuildContext context,
  WidgetRef ref,
  GeoPoint point,
) async {
  final apps = await ref.read(navigationHandoffProvider.future);
  if (!context.mounted) return;

  final choice = await showModalBottomSheet<NavigationApp>(
    context: context,
    backgroundColor: AppColor.elementBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (sheetContext) => NavigationChooserSheet(
      apps: apps,
      onSelect: (app) => Navigator.of(sheetContext).pop(app),
    ),
  );

  if (choice == null) return;

  await ref
      .read(navigationHandoffProvider.notifier)
      .open(choice, point.latitude, point.longitude);
}

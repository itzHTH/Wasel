import 'package:wasel_core/wasel_core.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:driver/features/ride/domain/entities/driver_ride_events.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_action_controller.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/driver_ride_state.dart';
import 'package:driver/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/wasel_location.dart';

part 'driver_route_polylines_provider.g.dart';

const _positionWait = Duration(seconds: 8);

class RouteUnavailableException implements Exception {
  const RouteUnavailableException(this.message);

  final String message;

  @override
  String toString() => message;
}

@riverpod
Future<Set<Polyline>> driverRoutePolylines(Ref ref) async {
  final stage = ref.watch(rideControllerProvider.select((s) => s.stage));
  final ride = ref.watch(rideControllerProvider.select((s) => s.currentRide));
  if (ride == null) return const {};

  final (GeoPoint, GeoPoint)? segment = switch (stage) {
    DriverStage.heading => await _driverToPickup(ref, ride),
    // An open offer draws the trip the driver is being asked to take, which is
    // the same pickup-to-drop-off line the ride itself follows.
    DriverStage.offerReceived ||
    DriverStage.inProgress => (ride.position, ride.dropPosition),
    _ => null,
  };
  if (segment == null) return const {};

  try {
    final result = await ref
        .read(getRouteUseCaseProvider)
        .call(RouteRequest(origin: segment.$1, destination: segment.$2));

    final palette = ref.read(appPaletteProvider);

    return result.when(
      success: (points) => _polylines(points, palette),
      failure: (error) =>
          _report(ref, errorMessageOf(error, fallback: _l10n.cannotDrawRoute)),
    );
  } catch (_) {
    return _report(ref, null);
  }
}

Future<(GeoPoint, GeoPoint)?> _driverToPickup(
  Ref ref,
  ReceiveRideRequest ride,
) async {
  final positions = ref.listen(deviceLocationProvider, (_, _) {});

  try {
    final position = await ref
        .read(deviceLocationProvider.future)
        .timeout(_positionWait);

    return (position.point, ride.position);
  } catch (_) {
    _report(ref, _l10n.noLocationNoRoute);
    return null;
  } finally {
    positions.close();
  }
}

Set<Polyline> _report(Ref ref, String? message) {
  if (!ref.mounted) return const {};

  ref
      .read(rideActionControllerProvider.notifier)
      .reportFailure(
        RouteUnavailableException(message ?? _l10n.cannotDrawRoute),
        StackTrace.current,
      );

  return const {};
}

Set<Polyline> _polylines(List<GeoPoint> points, AppColorsExtension palette) => {
  Polyline(
    polylineId: const PolylineId('driver_route'),
    points: points.map((p) => LatLng(p.latitude, p.longitude)).toList(),
    color: palette.primary500,
    width: 4,
    startCap: Cap.roundCap,
    endCap: Cap.roundCap,
    geodesic: true,
  ),
};

/// Localizations for a notifier, which has no BuildContext of its own.
///
/// Reads the active locale directly rather than through the Ref: these are
/// called after long awaits, when the Ref may already be unmounted.
DriverLocalizations get _l10n =>
    lookupDriverLocalizations(AppLocalizationController.currentLocale);

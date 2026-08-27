import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/core/extensions/geo_point_map_x.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';

part 'map_controller_provider.g.dart';

/// Holds the GoogleMapController of the currently mounted `AppMap`.
//
//? - Exposes a [Future] rather than a nullable controller so camera work can be
//?   queued *before* the platform view finishes creating itself — callers just
//?   `await` and the animation runs as soon as the map exists.
//
//? - Kept alive (`keepAlive: true`) because the controller outlives any single
//?   widget that wants to drive it; an auto-disposing holder would drop the
//?   completer the moment the last listener paused.
@Riverpod(keepAlive: true)
class MapControllerHolder extends _$MapControllerHolder {
  final _pending = Completer<GoogleMapController>();

  @override
  Future<GoogleMapController> build() => _pending.future;

  void attach(GoogleMapController controller) {
    if (!_pending.isCompleted) _pending.complete(controller);

    state = AsyncValue.data(controller);
  }

  /// Frames [point], for following a choice the rider just made elsewhere —
  /// picking a place out of search, say.
  Future<void> focusOn(GeoPoint point, {double zoom = _focusZoom}) async {
    final controller = await future;
    if (!ref.mounted) return;

    await controller.animateCamera(
      CameraUpdate.newLatLngZoom(point.toLatLng(), zoom),
    );
  }
}

/// Close enough to read street names, matching the "my location" recentre.
const double _focusZoom = 16;

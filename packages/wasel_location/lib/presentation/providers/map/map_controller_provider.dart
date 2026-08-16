import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
}

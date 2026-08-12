import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'device_location_provider.g.dart';

const _settings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 10,
);

/// How long the OS cache gets before callers fall back.
const _lastKnownTimeout = Duration(milliseconds: 600);

@riverpod
Stream<Position> deviceLocation(Ref ref) {
  return Geolocator.getPositionStream(locationSettings: _settings);
}

/// The OS cached fix — a cache read rather than a GPS acquisition, so it
/// settles immediately and holds no position stream open. Null when the cache
/// is empty or the permission was refused.
@Riverpod(keepAlive: true)
Future<LatLng?> lastKnownLocation(Ref ref) async {
  try {
    final last = await Geolocator.getLastKnownPosition().timeout(
      _lastKnownTimeout,
    );
    if (last != null) return LatLng(last.latitude, last.longitude);
  } catch (_) {
    // Permission denied / location off — callers decide what to show instead.
  }

  return null;
}

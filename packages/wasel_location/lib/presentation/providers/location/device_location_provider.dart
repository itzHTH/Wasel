import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/presentation/providers/location_di_providers.dart';

part 'device_location_provider.g.dart';

/// A continuous feed of the device's location.
//
//? - Uses StreamProvider to naturally handle push-based GPS updates.
//
//? - Auto-dispose ensures the OS location stream is closed and hardware
//?   is released the moment all UI listeners are gone (Battery Saver).
//
//? - Riverpod's [AsyncValue] gracefully holds the last known `.value`
//?   during transient errors (e.g., entering a tunnel).
@riverpod
Stream<DeviceFix> deviceLocation(Ref ref) {
  return ref.watch(watchDeviceLocationUseCaseProvider).call(null);
}

/// Derives just the coordinates from the location feed.
//
// Acts as a rebuild shield: //? prevents UI widgets that only need the coordinate
//? from needlessly rebuilding when only the heading or speed jitter.
@riverpod
GeoPoint? currentPoint(Ref ref) {
  return ref.watch(deviceLocationProvider).value?.point;
}

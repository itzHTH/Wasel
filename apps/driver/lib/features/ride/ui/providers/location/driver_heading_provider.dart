import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_location/wasel_location.dart';

part 'driver_heading_provider.g.dart';

/// The bearing the car marker is drawn at.
///
/// Stays driver-side: the rider's driver marker is fed by the SignalR hub, not
/// the device stream.
@riverpod
class DriverHeading extends _$DriverHeading {
  double _held = 0;

  @override
  double build() {
    final fix = ref.watch(deviceLocationProvider).value;
    if (fix != null && fix.isHeadingUsable) _held = fix.heading;

    return _held;
  }
}

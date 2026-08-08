import 'package:driver/features/ride/ui/providers/location/device_location_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'driver_heading_provider.g.dart';

@riverpod
class DriverHeading extends _$DriverHeading {
  static const _minSpeed = 1.0;

  double _held = 0;

  @override
  double build() {
    final position = ref.watch(deviceLocationProvider).value;
    if (position != null && _isUsable(position)) _held = position.heading;

    return _held;
  }

  bool _isUsable(Position position) =>
      position.heading >= 0 && position.speed >= _minSpeed;
}

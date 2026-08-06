import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_location_provider.g.dart';

const _settings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 10,
);

@riverpod
Stream<Position> deviceLocation(Ref ref) {
  return Geolocator.getPositionStream(locationSettings: _settings);
}

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_location_service.g.dart';

@riverpod
LocationSettings trackingSettings(Ref ref) =>
    const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

/// A thin, logic-free wrapper around [Geolocator] static methods.
///
/// This serves as the single testing seam (The Boundary) between the app and
/// the hardware. By keeping this //* class "dumb" (no try-catch, no mapping),
///  we can easily mock it in tests to simulate GPS timeouts, denied permissions,
/// and cold-start failures without needing a physical device.

class DeviceLocationService {
  DeviceLocationService(this.trackingSettings);

  /// Tracking profile for the continuous stream.
  final LocationSettings trackingSettings;

  /// How long a cold one-shot fix may take before it is abandoned.
  static const Duration defaultFixTimeout = Duration(seconds: 15);

  /// How long the cached-fix read may block. //! it must be 1 ms
  /// if not , there a proplem in device
  static const Duration lastKnownTimeout = Duration(milliseconds: 600);

  // Continuous position updates.
  //
  // Cold by construction: `Geolocator` //! only opens the platform stream when a
  //! listener subscribes,
  Stream<Position> positionStream({LocationSettings? settings}) {
    return Geolocator.getPositionStream(
      locationSettings: settings ?? trackingSettings,
    );
  }

  /// One fresh high-accuracy reading.
  Future<Position> currentPosition({Duration? timeout}) {
    return Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: timeout ?? defaultFixTimeout,
      ),
    );
  }

  /// The OS's cached reading, or null when it holds none.
  Future<Position?> lastKnownPosition() => Geolocator.getLastKnownPosition();

  /// Whether device location services are switched on.
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  /// Deep-links to the OS location settings screen.
  Future<bool> openLocationSettings() => Geolocator.openLocationSettings();

  /// Current permission, without prompting.
  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();

  /// Prompts for permission, if the OS will still show a prompt.
  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();
}

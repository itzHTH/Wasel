import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/entities/location_access.dart';

/// The domain's view of the device's location sensors.
/// Everything the apps currently do with `Geolocator` statics is expressed here
abstract class BaseDeviceLocationRepo {
  /// Continuous position updates, one per meaningful movement.
  ///
  /// The stream stays cold: nothing is requested from the OS until a listener
  /// subscribes, this make all of (marker updates, route drawing, camera centering) is in one stream./
  Stream<DeviceFix> watchLocation();

  /// A single high-accuracy reading, giving up after [timeout].
  ///
  /// Throws `LocationException` — `fixTimeout` when the sensors do not settle,
  //? `serviceDisabled` / `permissionDenied` when the preconditions fail.
  Future<DeviceFix> getCurrentLocation({Duration? timeout});

  /// The OS's cached reading, or null when the cache is empty.
  ///
  /// A cache read rather than an acquisition: it settles immediately and holds
  /// no sensor open, so is safe when app opened.
  Future<DeviceFix?> getLastKnownLocation();

  Future<bool> isLocationServiceEnabled();

  Future<void> openLocationSettings();

  Future<LocationAccess> checkAccess();

  /// Prompts for permission if the OS still allows it, then reports the result.
  ///
  /// Returns `permanentlyDenied` when no prompt could be shown —
  //*  callers must route that case to app settings instead of asking again.
  Future<LocationAccess> requestAccess();
}

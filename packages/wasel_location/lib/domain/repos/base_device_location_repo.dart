import 'package:wasel_location/domain/entities/device_fix.dart';
import 'package:wasel_location/domain/entities/location_access.dart';

/// The domain's view of the device's location sensors.
///
/// Everything the apps currently do with `Geolocator` statics is expressed here
/// so that exactly one implementation touches the plugin. Failures are signalled
/// with `LocationException` rather than `ApiResults` — see that class for why.
abstract class BaseDeviceLocationRepo {
  /// Continuous position updates, one per meaningful movement.
  ///
  /// The stream stays cold: nothing is requested from the OS until a listener
  /// subscribes, and the platform stream closes when the last one leaves. That
  /// property is what lets several providers (camera, markers, broadcaster)
  /// share a single OS subscription without any of them owning its lifetime.
  ///
  /// Errors arrive on the stream's error channel as `LocationException`.
  Stream<DeviceFix> watchLocation();

  /// A single high-accuracy reading, giving up after [timeout].
  ///
  /// Throws `LocationException` — `fixTimeout` when the sensors do not settle,
  /// `serviceDisabled` / `permissionDenied` when the preconditions fail.
  Future<DeviceFix> getCurrentLocation({Duration? timeout});

  /// The OS's cached reading, or null when the cache is empty.
  ///
  /// A cache read rather than an acquisition: it settles immediately and holds
  /// no sensor open, which is what makes it safe to call on app start to place
  /// an opening camera target. Returns null rather than throwing, because "no
  /// cached fix yet" is an ordinary state on a fresh install, not a failure.
  Future<DeviceFix?> getLastKnownLocation();

  /// Whether device location services are switched on.
  Future<bool> isLocationServiceEnabled();

  /// Deep-links to the OS location settings screen.
  Future<void> openLocationSettings();

  /// The app's current permission, without prompting.
  Future<LocationAccess> checkAccess();

  /// Prompts for permission if the OS still allows it, then reports the result.
  ///
  /// Returns `permanentlyDenied` when no prompt could be shown — callers must
  /// route that case to app settings instead of asking again.
  Future<LocationAccess> requestAccess();
}

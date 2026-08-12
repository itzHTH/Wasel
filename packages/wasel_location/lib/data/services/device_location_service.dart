import 'package:geolocator/geolocator.dart';

/// The single point in the whole codebase that touches `Geolocator`.
///
/// ## Why this class exists
///
/// `Geolocator`'s API is entirely static. Static calls cannot be substituted,
/// so any code that calls them directly can only be exercised against a real
/// device with real sensors, real permissions and real weather. That is the
/// reason neither app has a single test over its location code today, even
/// though the logic sitting on top of it — cold-fix fallbacks, timeouts,
/// heartbeat suppression, permission recovery — is some of the most failure-prone
/// in the product.
///
/// Wrapping the statics in an ordinary object turns them into a dependency that
/// can be passed in, and therefore replaced. `DeviceLocationRepo` takes one of
/// these; a test hands it a subclass that returns a scripted stream or throws a
/// `TimeoutException` on cue, and every branch above becomes reachable without
/// a phone.
///
/// ## Why it is deliberately dumb
///
/// There is no error handling, no domain type, and no policy here — it forwards
/// arguments and returns whatever the plugin returns. That is the point: a seam
/// is only trustworthy if there is nothing in it that could itself be wrong.
/// All translation (`Position` → `DeviceFix`, platform errors →
/// `LocationException`, `LocationPermission` → `LocationAccess`) happens one
/// layer up in the repository, where it is testable through this seam.
///
/// Every method is overridable for exactly that reason — do not make them
/// static, and do not add logic to them.
class DeviceLocationService {
  const DeviceLocationService();

  /// Tracking profile for the continuous stream.
  ///
  /// The 10 m distance filter is what keeps a moving vehicle from waking the
  /// app on every sensor tick; it is carried over unchanged from the driver
  /// app's tuning so the extraction does not alter battery or update behaviour.
  static const LocationSettings trackingSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  /// How long a cold one-shot fix may take before it is abandoned.
  ///
  /// Both apps independently settled on 15 seconds. Long enough for a GPS cold
  /// start outdoors, short enough that a user indoors gets told something rather
  /// than watching a spinner forever.
  static const Duration defaultFixTimeout = Duration(seconds: 15);

  /// How long the cached-fix read may block.
  ///
  /// This is a cache lookup, not an acquisition, so it should return almost
  /// instantly. The short ceiling exists because the platform channel can hang
  /// when permissions are in an odd state, and this call sits on the app-start
  /// path where a stall is visible as a blank map.
  static const Duration lastKnownTimeout = Duration(milliseconds: 600);

  /// Continuous position updates.
  ///
  /// Cold by construction: `Geolocator` only opens the platform stream when a
  /// listener subscribes, which is what allows several providers to share one
  /// OS subscription through a single broadcast provider upstream.
  Stream<Position> positionStream({LocationSettings? settings}) {
    return Geolocator.getPositionStream(
      locationSettings: settings ?? trackingSettings,
    );
  }

  /// One fresh high-accuracy reading.
  ///
  /// The timeout is expressed through `LocationSettings.timeLimit` rather than
  /// a `Future.timeout`, so the platform stops the sensors when it elapses
  /// instead of leaving an orphaned acquisition running behind an abandoned
  /// future.
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
  ///
  /// Distinct from permission: a user can grant the app location access and
  /// still have the device's location toggle off, in which case every
  /// acquisition fails no matter how the permission looks.
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

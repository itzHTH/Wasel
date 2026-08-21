/// The thresholds a vehicle marker animates by.
///
/// Gathered here so they can be read and tuned in one place rather than hunted
/// down inside the animator.
class VehicleMotionConfig {
  const VehicleMotionConfig._();

  /// How long a glide lasts before any cadence has been observed.
  static const Duration defaultGlide = Duration(seconds: 2);

  /// Bounds on the adaptive glide, so a burst of fixes cannot make the car
  /// twitch and a long silence cannot make it crawl.
  static const Duration minGlide = Duration(milliseconds: 500);
  static const Duration maxGlide = Duration(seconds: 4);

  /// A car turns, then drives — the rotation finishes inside this window.
  static const Duration turnWindow = Duration(milliseconds: 400);

  /// The floor between two emitted poses, capping the marker at ~30 Hz.
  ///
  /// Every marker update is re-serialised across the platform channel and
  /// re-decoded natively by the maps plugin, so emitting on every frame of a
  /// 60 Hz display doubles that work for motion the eye cannot tell apart.
  ///
  /// 30 rather than the round 33: two frames of a 60 Hz display are 33.3 ms, so
  /// a 33 ms floor sits on the boundary and frame jitter flips the marker
  /// between 30 Hz and 20 Hz. Uneven stepping reads worse than either rate.
  static const Duration minFrameGap = Duration(milliseconds: 30);

  /// Past this a hop is a tunnel exit or a bad fix, so the car is placed
  /// rather than slid across the gap.
  static const double teleportMeters = 300;

  /// Under this the direction between two fixes is GPS noise, not a turn.
  static const double minBearingMeters = 5;

  /// Under this the car counts as standing still and nothing is animated.
  static const double stillMeters = 0.5;

  /// A rotation smaller than this is not worth redrawing for.
  static const double minVisibleTurn = 0.1;
}

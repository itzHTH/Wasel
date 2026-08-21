import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:wasel_location/domain/entities/geo_point.dart';
import 'package:wasel_location/domain/geo/geo_interpolation.dart';
import 'package:wasel_location/presentation/animation/config/vehicle_motion_config.dart';
import 'package:wasel_location/presentation/animation/models/vehicle_pose.dart';
import 'package:wasel_location/presentation/animation/utils/motion_vsync.dart';

/// Glides a vehicle between the fixes that arrive for it.
class VehicleMotion extends ChangeNotifier
    implements ValueListenable<VehiclePose> {
  VehicleMotion({TickerProvider? vsync, DateTime Function()? clock})
    : _clock = clock ?? DateTime.now {
    _controller = AnimationController(
      vsync: vsync ?? MotionVsync(),
      duration: VehicleMotionConfig.defaultGlide,
    )..addListener(_onFrame);
  }

  final DateTime Function() _clock;

  late final AnimationController _controller;

  /// The pose being drawn right now.
  VehiclePose _pose = VehiclePose.unknown;

  /// The two poses the current glide runs between.
  _PoseTween _tween = const _PoseTween.fixed(VehiclePose.unknown);

  /// When the previous fix arrived, so the next glide can match the gap.
  DateTime? _lastFixAt;

  Duration _glideDuration = VehicleMotionConfig.defaultGlide;

  /// How far along the glide the last emitted pose was, for the frame cap.
  double _lastEmitProgress = 0;

  bool _hasFix = false;
  bool _disposed = false;

  @override
  VehiclePose get value => _pose;

  /// Whether a position has arrived yet. Until it has there is nothing to draw.
  bool get hasFix => _hasFix;

  /// How long the current glide runs for. The follow camera borrows it so the
  /// map and the marker move together.
  Duration get glideDuration => _glideDuration;

  /// The bearing the current glide is settling on.
  double get targetBearing => _tween.end.bearing;

  /// Glides the vehicle to target from wherever it is being drawn.
  void moveTo(GeoPoint target, {double? heading}) {
    if (_disposed) return;

    final now = _clock();
    // Set before any early return: the follow camera borrows this, and a stale
    // value makes it crawl toward a car that has already arrived.
    _glideDuration = _glideDurationFor(now);
    _lastFixAt = now;

    if (!_hasFix || _isTeleport(target)) {
      snapTo(target, heading: heading);
      return;
    }

    final bearing = _bearingTo(target, heading);
    if (_isStill(target, bearing)) return;

    // Begins at the pose on screen, never at the last target: fixes land
    // mid-glide, and starting from the target would jump the car forward to a
    // point it never visibly reached.
    _tween = _PoseTween(
      begin: _pose,
      end: VehiclePose(point: target, bearing: bearing),
    );
    _lastEmitProgress = 0;

    _controller
      ..duration = _glideDuration
      ..forward(from: 0);
  }

  /// Places the vehicle at target with no animation.
  void snapTo(GeoPoint target, {double? heading}) {
    if (_disposed) return;

    _controller.stop();

    final placed = VehiclePose(
      point: target,
      bearing: _hasFix ? _bearingTo(target, heading) : heading ?? 0,
    );

    _tween = _PoseTween.fixed(placed);
    _glideDuration = Duration.zero;
    _lastEmitProgress = 0;
    _hasFix = true;

    _emit(placed);
  }

  /// Forgets the vehicle, so nothing is drawn until a position arrives again.
  ///
  /// The rider's hub stops reporting a car when the ride ends; without this the
  /// marker would sit at its last known spot for the rest of the session.
  void clear() {
    if (_disposed || !_hasFix) return;

    _controller.stop();

    _tween = const _PoseTween.fixed(VehiclePose.unknown);
    _pose = VehiclePose.unknown;
    _glideDuration = Duration.zero;
    _lastEmitProgress = 0;
    _lastFixAt = null;
    _hasFix = false;

    notifyListeners();
  }

  void _onFrame() {
    final progress = _controller.value;
    if (_isThrottled(progress)) return;

    _emit(
      _tween.lerp(progress: progress, turnProgress: _turnProgressAt(progress)),
    );
  }

  /// Holds the marker to [VehicleMotionConfig.minFrameGap], expressed as a
  /// share of this glide. The closing frame always lands, so the car finishes
  /// exactly on the reported position.
  bool _isThrottled(double progress) {
    if (progress >= 1) return false;

    final gap =
        VehicleMotionConfig.minFrameGap.inMilliseconds /
        _glideDuration.inMilliseconds;

    if (progress - _lastEmitProgress < gap) return true;

    _lastEmitProgress = progress;
    return false;
  }

  void _emit(VehiclePose next) {
    if (next == _pose) return;

    _pose = next;
    notifyListeners();
  }

  /// Makes the glide last as long as the gap between the last two fixes.
  Duration _glideDurationFor(DateTime now) {
    final last = _lastFixAt;
    if (last == null) return VehicleMotionConfig.defaultGlide;

    return Duration(
      milliseconds: now
          .difference(last)
          .inMilliseconds
          .clamp(
            VehicleMotionConfig.minGlide.inMilliseconds,
            VehicleMotionConfig.maxGlide.inMilliseconds,
          ),
    );
  }

  /// A reported heading wins; otherwise the direction comes from the last two
  /// positions, and too small a step keeps the bearing we already had.
  double _bearingTo(GeoPoint target, double? heading) {
    if (heading != null) return GeoInterpolation.normalizeBearing(heading);

    if (_metersTo(target) < VehicleMotionConfig.minBearingMeters) {
      return _pose.bearing;
    }

    return GeoInterpolation.initialBearing(_pose.point, target);
  }

  /// A tunnel exit, a resume, or a bad fix. Sliding across it would look
  /// broken, so the car is placed instead.
  bool _isTeleport(GeoPoint target) =>
      _metersTo(target) > VehicleMotionConfig.teleportMeters;

  /// A stopped car still reports fixes that wobble by centimetres. Animating
  /// those would jitter the marker for nothing, so no glide is started.
  bool _isStill(GeoPoint target, double bearing) =>
      _metersTo(target) < VehicleMotionConfig.stillMeters &&
      GeoInterpolation.bearingDelta(_pose.bearing, bearing).abs() <
          VehicleMotionConfig.minVisibleTurn;

  double _metersTo(GeoPoint target) =>
      GeoInterpolation.distanceBetween(_pose.point, target);

  /// The turn is over within [VehicleMotionConfig.turnWindow], so the car
  /// points where it is going while it is still travelling there.
  double _turnProgressAt(double progress) {
    final turnShare =
        VehicleMotionConfig.turnWindow.inMilliseconds /
        _glideDuration.inMilliseconds;

    if (turnShare >= 1) return progress;

    return Curves.easeOut.transform((progress / turnShare).clamp(0.0, 1.0));
  }

  /// Safe to call twice: a provider can be torn down while a rebuild is still
  /// unwinding.
  @override
  void dispose() {
    if (_disposed) return;

    _disposed = true;
    _controller.removeListener(_onFrame);
    _controller.dispose();
    super.dispose();
  }
}

/// The two ends of one glide, sampled to give the pose in between.
class _PoseTween {
  const _PoseTween({required this.begin, required this.end});

  /// A glide that goes nowhere, for a car that was placed rather than moved.
  const _PoseTween.fixed(VehiclePose pose) : begin = pose, end = pose;

  final VehiclePose begin;
  final VehiclePose end;

  VehiclePose lerp({required double progress, required double turnProgress}) =>
      VehiclePose(
        point: GeoInterpolation.lerpPoint(begin.point, end.point, progress),
        bearing: GeoInterpolation.lerpBearing(
          begin.bearing,
          end.bearing,
          turnProgress,
        ),
      );
}

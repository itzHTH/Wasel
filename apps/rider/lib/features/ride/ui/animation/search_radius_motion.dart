import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:wasel_location/wasel_location.dart';

/// Drives the expanding "looking for a driver" radius and its opacity pulse.
class SearchRadiusMotion extends ChangeNotifier {
  SearchRadiusMotion({TickerProvider? stepVsync, TickerProvider? pulseVsync}) {
    _step = AnimationController(
      vsync: stepVsync ?? MotionVsync(),
      duration: stepDuration,
    )..addListener(_onStepFrame);

    _pulse = AnimationController(
      vsync: pulseVsync ?? MotionVsync(),
      duration: pulsePeriod,
    )..addListener(notifyListeners);
  }

  static const stepMeters = 2000.0;
  static const maxMeters = 10000.0;
  static const stepInterval = Duration(seconds: 60);
  static const stepDuration = Duration(milliseconds: 800);
  static const pulsePeriod = Duration(milliseconds: 2000);

  late final AnimationController _step;
  late final AnimationController _pulse;

  Timer? _stepTimer;
  bool _running = false;
  bool _disposed = false;

  double _radiusMeters = 0;
  double _fromMeters = 0;
  double _targetMeters = 0;

  /// The radius being drawn right now, in metres.
  double get radiusMeters => _radiusMeters;

  /// The opacity swing, in `-1..1`. Flat at zero while a step is expanding —
  /// the growth is the movement there, and pulsing over it reads as a flicker.
  double get pulse =>
      _pulse.isAnimating ? math.sin(2 * math.pi * _pulse.value) : 0;

  bool get isRunning => _running;

  void start() {
    if (_running || _disposed) return;

    _running = true;
    _stepTimer = Timer.periodic(stepInterval, (_) => _stepUp());
    _animateTo(stepMeters);
  }

  void stop() {
    if (_disposed) return;

    _stepTimer?.cancel();
    _stepTimer = null;
    _step.stop();
    _pulse.stop();

    final wasRunning = _running || _radiusMeters != 0;

    _running = false;
    _radiusMeters = 0;
    _fromMeters = 0;
    _targetMeters = 0;

    if (wasRunning) notifyListeners();
  }

  void _stepUp() {
    if (_targetMeters >= maxMeters) return;

    _animateTo(math.min(maxMeters, _targetMeters + stepMeters));

    if (_targetMeters >= maxMeters) {
      _stepTimer?.cancel();
      _stepTimer = null;
    }
  }

  void _animateTo(double targetMeters) {
    _fromMeters = _radiusMeters;
    _targetMeters = targetMeters;

    _pulse.stop();
    _pulse.value = 0;

    _step.forward(from: 0);
  }

  void _onStepFrame() {
    final eased = Curves.easeOutCubic.transform(_step.value);
    _radiusMeters = _fromMeters + (_targetMeters - _fromMeters) * eased;

    if (_step.isCompleted) {
      _radiusMeters = _targetMeters;
      // Repeats for as long as the search runs; each new step interrupts it.
      _pulse.repeat();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _stepTimer?.cancel();
    _stepTimer = null;
    _step.dispose();
    _pulse.dispose();
    super.dispose();
  }
}

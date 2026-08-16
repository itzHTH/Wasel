import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasal/features/ride/ui/providers/request_ride/request_ride_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_controller.dart';
import 'package:wasal/features/ride/ui/providers/ride_controller/ride_state.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

part 'search_radius_circles_provider.g.dart';

@riverpod
class SearchRadiusCircles extends _$SearchRadiusCircles {
  static const _stepMeters = 2000.0;

  static const _maxMeters = 10000.0;

  static const _stepInterval = Duration(seconds: 60);

  static const _stepAnimationTick = Duration(milliseconds: 16);

  static const _stepAnimationMs = 800;

  static const _pulseTick = Duration(milliseconds: 50);

  static const _pulsePeriodMs = 2000;

  static const _fillAlpha = 0.08;

  static const _strokeAlpha = 0.4;

  static const _fillPulseSwing = 0.05;

  static const _strokePulseSwing = 0.25;

  Timer? _stepTimer;
  Timer? _stepAnimationTimer;
  Timer? _pulseTimer;

  bool _running = false;
  double _targetMeters = 0;
  double _radiusMeters = 0;
  double _animationFromMeters = 0;
  int _animationElapsedMs = 0;
  int _pulseElapsedMs = 0;

  @override
  Set<Circle> build() {
    ref.onDispose(_reset);

    final requestSent = ref.watch(
      requestRideControllerProvider.select((s) => s.value != null),
    );
    final stage = requestSent
        ? ref.watch(rideControllerProvider.select((s) => s.stage))
        : RideStage.idel;

    if (stage != RideStage.searching) {
      _reset();
      return const {};
    }

    if (!_running) {
      _running = true;
      _stepTimer = Timer.periodic(_stepInterval, (_) => _stepUp());
      _animateTo(_stepMeters);
    }

    return _circles();
  }

  void _stepUp() {
    if (_targetMeters >= _maxMeters) return;
    _animateTo(math.min(_maxMeters, _targetMeters + _stepMeters));

    if (_targetMeters >= _maxMeters) {
      _stepTimer?.cancel();
      _stepTimer = null;
    }
  }

  void _animateTo(double targetMeters) {
    _targetMeters = targetMeters;
    _animationFromMeters = _radiusMeters;
    _animationElapsedMs = 0;

    _pulseTimer?.cancel();
    _pulseTimer = null;
    _pulseElapsedMs = 0;

    _stepAnimationTimer?.cancel();
    _stepAnimationTimer = Timer.periodic(
      _stepAnimationTick,
      (_) => _onStepAnimationTick(),
    );
  }

  void _onStepAnimationTick() {
    if (!ref.mounted) return;

    _animationElapsedMs += _stepAnimationTick.inMilliseconds;
    final progress = math.min(1.0, _animationElapsedMs / _stepAnimationMs);
    final eased = 1 - math.pow(1 - progress, 3).toDouble();
    _radiusMeters =
        _animationFromMeters + (_targetMeters - _animationFromMeters) * eased;

    if (progress >= 1) {
      _radiusMeters = _targetMeters;
      _stepAnimationTimer?.cancel();
      _stepAnimationTimer = null;
      _startPulse();
    }

    state = _circles();
  }

  void _startPulse() {
    _pulseElapsedMs = 0;
    _pulseTimer?.cancel();
    _pulseTimer = Timer.periodic(_pulseTick, (_) {
      if (!ref.mounted) return;
      _pulseElapsedMs += _pulseTick.inMilliseconds;
      state = _circles();
    });
  }

  void _reset() {
    _stepTimer?.cancel();
    _stepTimer = null;
    _stepAnimationTimer?.cancel();
    _stepAnimationTimer = null;
    _pulseTimer?.cancel();
    _pulseTimer = null;

    _running = false;
    _targetMeters = 0;
    _radiusMeters = 0;
    _animationFromMeters = 0;
    _animationElapsedMs = 0;
    _pulseElapsedMs = 0;
  }

  double get _pulse => _pulseTimer == null
      ? 0
      : math.sin(2 * math.pi * _pulseElapsedMs / _pulsePeriodMs);

  Set<Circle> _circles() {
    final pickup = ref.read(rideDraftProvider).pickup;
    if (pickup == null) return const {};

    final pulse = _pulse;

    return {
      Circle(
        circleId: const CircleId('search_radius'),
        center: pickup,
        radius: _radiusMeters,
        fillColor: AppColor.primary500.withValues(
          alpha: _fillAlpha + _fillPulseSwing * pulse,
        ),
        strokeColor: AppColor.primary500.withValues(
          alpha: _strokeAlpha + _strokePulseSwing * pulse,
        ),
        strokeWidth: 1,
      ),
    };
  }
}

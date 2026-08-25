import 'package:flutter/animation.dart';

/// One search heartbeat, shared by the rider's expanding map radius and the
/// radar badge both apps show while a search is running. The two read as the
/// same gesture only while they keep the same period and curve, so neither
/// side gets to carry its own numbers.
class RideSearchMotion {
  RideSearchMotion._();

  static const pulsePeriod = Duration(milliseconds: 2000);
  static const expansionDuration = Duration(milliseconds: 800);
  static const expansionCurve = Curves.easeOutCubic;

  /// Rings in flight at once, evenly spread across the cycle.
  static const ringCount = 3;

  static const peakRingAlpha = 0.6;

  /// How far the core dot dims at the bottom of its breath.
  static const coreAlphaSwing = 0.25;
}

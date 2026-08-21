import 'package:flutter/scheduler.dart';

/// Supplies a [Ticker] to an animation that lives outside the widget tree.
///
/// A provider has no `State` to take `SingleTickerProviderStateMixin` from, and
/// a periodic timer would keep firing while the app is in the background. Frame
/// callbacks stop when the engine stops drawing, so this idles for free.
///
/// The gap this leaves: a bare ticker has no `TickerMode` ancestor, so it is
/// not muted when the map is covered by a pushed route. Handing the animator a
/// real `TickerProvider` from the widget layer is the fix, and is deferred.
class MotionVsync implements TickerProvider {
  Ticker? _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(_ticker == null, 'A MotionVsync drives exactly one controller.');
    return _ticker = Ticker(onTick, debugLabel: 'VehicleMotion');
  }
}

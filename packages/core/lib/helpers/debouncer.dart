import 'dart:async';

import 'package:flutter/foundation.dart';

/// Collapses a burst of calls into one, fired [duration] after the last of them.
class Debouncer {
  Debouncer(this.duration);

  final Duration duration;

  Timer? _timer;
  bool _disposed = false;

  bool get isPending => _timer?.isActive ?? false;

  void run(VoidCallback action) {
    if (_disposed) return;
    _timer?.cancel();
    _timer = Timer(duration, () {
      _timer = null;
      action();
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _disposed = true;
    cancel();
  }
}

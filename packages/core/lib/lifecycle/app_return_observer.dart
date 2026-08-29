import 'package:flutter/widgets.dart';

VoidCallback? observeAppReturn(VoidCallback onReturn) {
  final WidgetsBinding binding;
  try {
    binding = WidgetsBinding.instance;
  } catch (_) {
    return null;
  }

  final observer = _AppReturnObserver(onReturn);
  binding.addObserver(observer);
  return () => binding.removeObserver(observer);
}

class _AppReturnObserver with WidgetsBindingObserver {
  _AppReturnObserver(this.onReturn);

  final VoidCallback onReturn;

  bool _wasAway = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        final returning = _wasAway;
        _wasAway = false;
        if (returning) onReturn();

      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _wasAway = true;

      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}

/// Whether the UI is on screen right now.
///
/// Null before the first lifecycle event, which is a cold start with the UI
/// coming up — treated as foregrounded so nothing alerts over a visible app.
bool get isAppForegrounded {
  try {
    final state = WidgetsBinding.instance.lifecycleState;
    // `inactive` is still on screen — a pulled-down shade, a system permission
    // dialog, an incoming-call banner. Alerting over it would interrupt a
    // driver who is already looking at the app.
    return state == null ||
        state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive;
  } catch (_) {
    return true;
  }
}

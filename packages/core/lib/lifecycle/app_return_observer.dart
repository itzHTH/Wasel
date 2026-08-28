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

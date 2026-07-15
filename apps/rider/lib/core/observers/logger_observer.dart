import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class LoggerObserver extends ProviderObserver {
  const LoggerObserver();

  String _name(ProviderObserverContext c) =>
      c.provider.name ?? c.provider.runtimeType.toString();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    debugPrint('🟢 CREATED: ${_name(context)}');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    debugPrint('🔄 UPDATED: ${_name(context)}');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    debugPrint('🔴 DISPOSED: ${_name(context)}');
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    debugPrint('❌ FAILED: ${_name(context)} → $error');
  }
}

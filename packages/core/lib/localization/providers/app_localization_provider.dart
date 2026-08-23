import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';
import 'package:wasel_core/localization/app_local_type.dart';

part 'app_localization_provider.g.dart';

@riverpod
Locale initialLocale(ref) => Locale(AppLocaleType.arabic.code);

@riverpod
class AppLocalizationController extends _$AppLocalizationController {
  @override
  Locale build() => ref.watch(initialLocaleProvider);

  static Future<Locale> restore() async {
    final saved = await AppLocalCache.getString(AppConstants.localeKey);
    return Locale(saved.isEmpty ? AppLocaleType.arabic.code : saved);
  }

  //
  int _writeSeq = 0;
  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;
    state = locale;

    // Rapid toggles can complete their writes out of order.
    final seq = ++_writeSeq;
    try {
      final ok = await AppLocalCache.setData(
        AppConstants.localeKey,
        locale.languageCode,
      );
      if (seq != _writeSeq) return;
      if (!ok && AppConstants.isDebug) {
        debugPrint('locale was not persisted; it will reset on relaunch');
      }
    } catch (error, stackTrace) {
      if (seq != _writeSeq) return;
      // A failed write must not surface as an unhandled async error: the locale
      // is already applied, it just will not survive a relaunch.
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'wasel_core',
          context: ErrorDescription('persisting the selected locale'),
        ),
      );
    }
  }
}

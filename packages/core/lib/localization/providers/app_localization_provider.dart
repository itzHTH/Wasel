import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';
import 'package:wasel_core/localization/app_local_type.dart';

part 'app_localization_provider.g.dart';

@riverpod
Locale initialLocale(Ref ref) => Locale(AppLocaleType.arabic.code);

@Riverpod(keepAlive: true)
class AppLocalizationController extends _$AppLocalizationController {
  /// The active locale, readable without a Ref or a BuildContext.
  static Locale currentLocale = Locale(AppLocaleType.arabic.code);

  @override
  Locale build() {
    final locale = ref.watch(initialLocaleProvider);
    currentLocale = locale;
    return locale;
  }

  static Future<Locale> restore() async {
    final saved = await AppLocalCache.getString(AppConstants.localeKey);

    // A code we do not ship would resolve to Arabic in the widget tree while
    // the mirror kept the bogus value, making every context-free lookup throw.
    final type = AppLocaleType.values.firstWhere(
      (value) => value.code == saved,
      orElse: () => AppLocaleType.arabic,
    );
    final locale = Locale(type.code);

    // Set here too: a request can leave before the first build, and the mirror
    // must not depend on some widget having watched the controller first.
    currentLocale = locale;

    return locale;
  }

  //
  int _writeSeq = 0;
  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;
    state = locale;
    currentLocale = locale;

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

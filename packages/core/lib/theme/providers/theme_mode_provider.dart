import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/const/app_constants.dart';
import 'package:wasel_core/helpers/app_local_cache.dart';
import 'package:wasel_core/theme/app_brand.dart';
import 'package:wasel_core/theme/app_colors_extension.dart';

part 'theme_mode_provider.g.dart';

@riverpod
AppBrand appBrand(Ref ref) => AppBrand.rider;

/// The mode restored from local storage before runApp is called.
@riverpod
ThemeMode initialThemeMode(Ref ref) => ThemeMode.system;

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ref.watch(initialThemeModeProvider);

  int _writeSeq = 0;

  Future<void> setMode(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;

    // Rapid toggles can complete their writes out of order, which would
    // persist a mode the user already moved off. Only the newest write wins.
    final seq = ++_writeSeq;
    try {
      final ok = await AppLocalCache.setData(
        AppConstants.themeModeKey,
        mode.name,
      );
      if (seq != _writeSeq) return;
      if (!ok && AppConstants.isDebug) {
        debugPrint('themeMode was not persisted; it will reset on relaunch');
      }
    } catch (error, stackTrace) {
      if (seq != _writeSeq) return;
      // A failed write must not surface as an unhandled async error: the mode
      // is already applied, it just will not survive a relaunch.
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'wasel_core',
          context: ErrorDescription('persisting the selected theme mode'),
        ),
      );
    }
  }

  /// Reads the persisted mode. Call before `runApp` and feed the result into
  /// initialThemeModeProvider.
  static Future<ThemeMode> restore() async {
    final saved = await AppLocalCache.getString(AppConstants.themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => ThemeMode.system,
    );
  }
}

/// The OS-level brightness, kept live so `system` mode reacts to the user
/// flipping appearance while the app is foregrounded.
@Riverpod(keepAlive: true)
class PlatformBrightness extends _$PlatformBrightness {
  @override
  Brightness build() {
    // Read through PlatformDispatcher, which needs no widget binding, so this
    // provider still resolves in a plain unit test. The observer is what needs
    // a binding, and it is only worth having where one exists.
    final dispatcher = PlatformDispatcher.instance;

    final binding = _maybeBinding;
    if (binding != null) {
      final observer = _BrightnessObserver(
        () => state = dispatcher.platformBrightness,
      );
      binding.addObserver(observer);
      ref.onDispose(() => binding.removeObserver(observer));
    }

    return dispatcher.platformBrightness;
  }

  /// `WidgetsBinding.instance` throws when `runApp` has not run. There is no
  /// `maybeInstance`, so this is the only way to ask without exploding.
  static WidgetsBinding? get _maybeBinding {
    try {
      return WidgetsBinding.instance;
    } catch (_) {
      return null;
    }
  }
}

class _BrightnessObserver with WidgetsBindingObserver {
  _BrightnessObserver(this.onChanged);

  final VoidCallback onChanged;

  @override
  void didChangePlatformBrightness() => onChanged();
}

/// The active palette, for code that has no `BuildContext` — map overlays,
/// painters, anything built inside a provider. Widgets should use
/// `context.colors` instead, which reads the same palette off the theme.
@Riverpod(keepAlive: true)
AppColorsExtension appPalette(Ref ref) {
  final brightness = switch (ref.watch(themeModeControllerProvider)) {
    ThemeMode.light => Brightness.light,
    ThemeMode.dark => Brightness.dark,
    ThemeMode.system => ref.watch(platformBrightnessProvider),
  };
  return ref.watch(appBrandProvider).paletteFor(brightness);
}

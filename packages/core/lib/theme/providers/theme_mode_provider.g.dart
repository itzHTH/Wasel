// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appBrand)
final appBrandProvider = AppBrandProvider._();

final class AppBrandProvider
    extends $FunctionalProvider<AppBrand, AppBrand, AppBrand>
    with $Provider<AppBrand> {
  AppBrandProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBrandProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBrandHash();

  @$internal
  @override
  $ProviderElement<AppBrand> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppBrand create(Ref ref) {
    return appBrand(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppBrand value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppBrand>(value),
    );
  }
}

String _$appBrandHash() => r'a6402fde0ec90b57e4fb091318877de4c12b5c72';

/// The mode restored from local storage before runApp is called.

@ProviderFor(initialThemeMode)
final initialThemeModeProvider = InitialThemeModeProvider._();

/// The mode restored from local storage before runApp is called.

final class InitialThemeModeProvider
    extends $FunctionalProvider<ThemeMode, ThemeMode, ThemeMode>
    with $Provider<ThemeMode> {
  /// The mode restored from local storage before runApp is called.
  InitialThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialThemeModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialThemeModeHash();

  @$internal
  @override
  $ProviderElement<ThemeMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeMode create(Ref ref) {
    return initialThemeMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$initialThemeModeHash() => r'4b9bb866caf2286f201ece32dd996db38de6a1d2';

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

final class ThemeModeControllerProvider
    extends $NotifierProvider<ThemeModeController, ThemeMode> {
  ThemeModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeControllerHash();

  @$internal
  @override
  ThemeModeController create() => ThemeModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeControllerHash() =>
    r'800bbfa916956bb9d5a0891b38bfcaa6199ed1da';

abstract class _$ThemeModeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The OS-level brightness, kept live so `system` mode reacts to the user
/// flipping appearance while the app is foregrounded.

@ProviderFor(PlatformBrightness)
final platformBrightnessProvider = PlatformBrightnessProvider._();

/// The OS-level brightness, kept live so `system` mode reacts to the user
/// flipping appearance while the app is foregrounded.
final class PlatformBrightnessProvider
    extends $NotifierProvider<PlatformBrightness, Brightness> {
  /// The OS-level brightness, kept live so `system` mode reacts to the user
  /// flipping appearance while the app is foregrounded.
  PlatformBrightnessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformBrightnessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$platformBrightnessHash();

  @$internal
  @override
  PlatformBrightness create() => PlatformBrightness();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Brightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Brightness>(value),
    );
  }
}

String _$platformBrightnessHash() =>
    r'd09f8b825b9234d0e3ca0e5e5422519fda2b12aa';

/// The OS-level brightness, kept live so `system` mode reacts to the user
/// flipping appearance while the app is foregrounded.

abstract class _$PlatformBrightness extends $Notifier<Brightness> {
  Brightness build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Brightness, Brightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Brightness, Brightness>,
              Brightness,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The active palette, for code that has no `BuildContext` — map overlays,
/// painters, anything built inside a provider. Widgets should use
/// `context.colors` instead, which reads the same palette off the theme.

@ProviderFor(appPalette)
final appPaletteProvider = AppPaletteProvider._();

/// The active palette, for code that has no `BuildContext` — map overlays,
/// painters, anything built inside a provider. Widgets should use
/// `context.colors` instead, which reads the same palette off the theme.

final class AppPaletteProvider
    extends
        $FunctionalProvider<
          AppColorsExtension,
          AppColorsExtension,
          AppColorsExtension
        >
    with $Provider<AppColorsExtension> {
  /// The active palette, for code that has no `BuildContext` — map overlays,
  /// painters, anything built inside a provider. Widgets should use
  /// `context.colors` instead, which reads the same palette off the theme.
  AppPaletteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appPaletteProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appPaletteHash();

  @$internal
  @override
  $ProviderElement<AppColorsExtension> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppColorsExtension create(Ref ref) {
    return appPalette(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppColorsExtension value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppColorsExtension>(value),
    );
  }
}

String _$appPaletteHash() => r'6b7d82230799dcc976bce1545c50fec0ea358c3b';

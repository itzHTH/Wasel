// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_localization_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initialLocale)
final initialLocaleProvider = InitialLocaleProvider._();

final class InitialLocaleProvider
    extends $FunctionalProvider<Locale, Locale, Locale>
    with $Provider<Locale> {
  InitialLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialLocaleHash();

  @$internal
  @override
  $ProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale create(Ref ref) {
    return initialLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$initialLocaleHash() => r'2365fa40aaf3b58a973a62c28c5c9e728804fff5';

@ProviderFor(AppLocalizationController)
final appLocalizationControllerProvider = AppLocalizationControllerProvider._();

final class AppLocalizationControllerProvider
    extends $NotifierProvider<AppLocalizationController, Locale> {
  AppLocalizationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocalizationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocalizationControllerHash();

  @$internal
  @override
  AppLocalizationController create() => AppLocalizationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocalizationControllerHash() =>
    r'0f9a3f92ec13e7b5c33910da23d075b3a3e6f63f';

abstract class _$AppLocalizationController extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

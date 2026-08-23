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

String _$initialLocaleHash() => r'b2763c6a56dc868bd328ceba6821a1dea46e2043';

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
        isAutoDispose: false,
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
    r'a4b3b03e62c856a13c415e2b0e860d695c9b3387';

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

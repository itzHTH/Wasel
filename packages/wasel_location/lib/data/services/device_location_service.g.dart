// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_location_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trackingSettings)
final trackingSettingsProvider = TrackingSettingsProvider._();

final class TrackingSettingsProvider
    extends
        $FunctionalProvider<
          LocationSettings,
          LocationSettings,
          LocationSettings
        >
    with $Provider<LocationSettings> {
  TrackingSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackingSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackingSettingsHash();

  @$internal
  @override
  $ProviderElement<LocationSettings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocationSettings create(Ref ref) {
    return trackingSettings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationSettings>(value),
    );
  }
}

String _$trackingSettingsHash() => r'0b1d01e0cd55c2381ea45c155168e22fcedfd804';

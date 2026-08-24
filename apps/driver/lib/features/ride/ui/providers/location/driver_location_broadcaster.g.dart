// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_location_broadcaster.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverLocationBroadcaster)
final driverLocationBroadcasterProvider = DriverLocationBroadcasterProvider._();

final class DriverLocationBroadcasterProvider
    extends $NotifierProvider<DriverLocationBroadcaster, void> {
  DriverLocationBroadcasterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverLocationBroadcasterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverLocationBroadcasterHash();

  @$internal
  @override
  DriverLocationBroadcaster create() => DriverLocationBroadcaster();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$driverLocationBroadcasterHash() =>
    r'2e86edd4aab2ae90528b9a56198e2bbb83ca9519';

abstract class _$DriverLocationBroadcaster extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

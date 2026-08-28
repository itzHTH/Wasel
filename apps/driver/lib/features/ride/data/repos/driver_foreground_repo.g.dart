// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_foreground_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverForegroundRepo)
final driverForegroundRepoProvider = DriverForegroundRepoProvider._();

final class DriverForegroundRepoProvider
    extends
        $FunctionalProvider<
          DriverForegroundRepo,
          DriverForegroundRepo,
          DriverForegroundRepo
        >
    with $Provider<DriverForegroundRepo> {
  DriverForegroundRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverForegroundRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverForegroundRepoHash();

  @$internal
  @override
  $ProviderElement<DriverForegroundRepo> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriverForegroundRepo create(Ref ref) {
    return driverForegroundRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverForegroundRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverForegroundRepo>(value),
    );
  }
}

String _$driverForegroundRepoHash() =>
    r'e54385f0ce7a0b8c5fb0c9d86cf36ed00ebd0633';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_foreground_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverForegroundService)
final driverForegroundServiceProvider = DriverForegroundServiceProvider._();

final class DriverForegroundServiceProvider
    extends
        $FunctionalProvider<
          IDriverForegroundService,
          IDriverForegroundService,
          IDriverForegroundService
        >
    with $Provider<IDriverForegroundService> {
  DriverForegroundServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverForegroundServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverForegroundServiceHash();

  @$internal
  @override
  $ProviderElement<IDriverForegroundService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IDriverForegroundService create(Ref ref) {
    return driverForegroundService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDriverForegroundService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDriverForegroundService>(value),
    );
  }
}

String _$driverForegroundServiceHash() =>
    r'3eb13fcf8d61a516b3099936435e7eff8dbe9d9e';

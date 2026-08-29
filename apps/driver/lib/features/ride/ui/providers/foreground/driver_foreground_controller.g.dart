// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_foreground_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverForegroundController)
final driverForegroundControllerProvider =
    DriverForegroundControllerProvider._();

final class DriverForegroundControllerProvider
    extends $NotifierProvider<DriverForegroundController, void> {
  DriverForegroundControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverForegroundControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverForegroundControllerHash();

  @$internal
  @override
  DriverForegroundController create() => DriverForegroundController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$driverForegroundControllerHash() =>
    r'022360dcb23adb879afa690f6f668588a09d03d2';

abstract class _$DriverForegroundController extends $Notifier<void> {
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

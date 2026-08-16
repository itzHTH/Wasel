// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverProfileController)
final driverProfileControllerProvider = DriverProfileControllerProvider._();

final class DriverProfileControllerProvider
    extends $AsyncNotifierProvider<DriverProfileController, DriverProfile?> {
  DriverProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: _noRetry,
        name: r'driverProfileControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverProfileControllerHash();

  @$internal
  @override
  DriverProfileController create() => DriverProfileController();
}

String _$driverProfileControllerHash() =>
    r'acfa1c9c8a8412193b19894005578e7c981e9ad8';

abstract class _$DriverProfileController
    extends $AsyncNotifier<DriverProfile?> {
  FutureOr<DriverProfile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DriverProfile?>, DriverProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DriverProfile?>, DriverProfile?>,
              AsyncValue<DriverProfile?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

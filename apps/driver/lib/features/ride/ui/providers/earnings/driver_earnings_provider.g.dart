// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverEarningsController)
final driverEarningsControllerProvider = DriverEarningsControllerProvider._();

final class DriverEarningsControllerProvider
    extends $AsyncNotifierProvider<DriverEarningsController, DriverEarnings?> {
  DriverEarningsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverEarningsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverEarningsControllerHash();

  @$internal
  @override
  DriverEarningsController create() => DriverEarningsController();
}

String _$driverEarningsControllerHash() =>
    r'0d5a58f9f9c15befb069d56cb3f247debd5f3e8a';

abstract class _$DriverEarningsController
    extends $AsyncNotifier<DriverEarnings?> {
  FutureOr<DriverEarnings?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DriverEarnings?>, DriverEarnings?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DriverEarnings?>, DriverEarnings?>,
              AsyncValue<DriverEarnings?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

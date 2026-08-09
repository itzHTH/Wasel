// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_balance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverBalanceController)
final driverBalanceControllerProvider = DriverBalanceControllerProvider._();

final class DriverBalanceControllerProvider
    extends $NotifierProvider<DriverBalanceController, double> {
  DriverBalanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverBalanceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverBalanceControllerHash();

  @$internal
  @override
  DriverBalanceController create() => DriverBalanceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$driverBalanceControllerHash() =>
    r'2dfe55c6f8f1f3bd2506592df2ef4dcbfbffc14a';

abstract class _$DriverBalanceController extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

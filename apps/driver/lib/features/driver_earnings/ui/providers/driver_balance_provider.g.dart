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
    extends $AsyncNotifierProvider<DriverBalanceController, double> {
  DriverBalanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: _noRetry,
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
}

String _$driverBalanceControllerHash() =>
    r'8d2b912e1cf212fff75236b93c23237284fa802b';

abstract class _$DriverBalanceController extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<double>, double>,
              AsyncValue<double>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

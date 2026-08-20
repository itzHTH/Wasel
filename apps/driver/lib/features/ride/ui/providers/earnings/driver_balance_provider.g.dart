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
}

String _$driverBalanceControllerHash() =>
    r'beed681ab8c6a612d88485d4f4a61af9ba07ee3a';

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

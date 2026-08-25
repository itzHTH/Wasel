// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverEarningsController)
final driverEarningsControllerProvider = DriverEarningsControllerFamily._();

final class DriverEarningsControllerProvider
    extends $AsyncNotifierProvider<DriverEarningsController, DriverEarnings> {
  DriverEarningsControllerProvider._({
    required DriverEarningsControllerFamily super.from,
    required EarningsRange super.argument,
  }) : super(
         retry: _noRetry,
         name: r'driverEarningsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$driverEarningsControllerHash();

  @override
  String toString() {
    return r'driverEarningsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DriverEarningsController create() => DriverEarningsController();

  @override
  bool operator ==(Object other) {
    return other is DriverEarningsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$driverEarningsControllerHash() =>
    r'd6c63e1f9d315ccc62df028a72096324af0c2f3e';

final class DriverEarningsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DriverEarningsController,
          AsyncValue<DriverEarnings>,
          DriverEarnings,
          FutureOr<DriverEarnings>,
          EarningsRange
        > {
  DriverEarningsControllerFamily._()
    : super(
        retry: _noRetry,
        name: r'driverEarningsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DriverEarningsControllerProvider call(EarningsRange range) =>
      DriverEarningsControllerProvider._(argument: range, from: this);

  @override
  String toString() => r'driverEarningsControllerProvider';
}

abstract class _$DriverEarningsController
    extends $AsyncNotifier<DriverEarnings> {
  late final _$args = ref.$arg as EarningsRange;
  EarningsRange get range => _$args;

  FutureOr<DriverEarnings> build(EarningsRange range);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DriverEarnings>, DriverEarnings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DriverEarnings>, DriverEarnings>,
              AsyncValue<DriverEarnings>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

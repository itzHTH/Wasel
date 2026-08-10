// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Today's earnings, read only while the driver is taking rides.
///
/// Going online triggers the fetch and going offline drops the figures, so an
/// offline driver is never shown a total that has since moved on. Finishing a
/// ride re-reads them, because that is the moment they change.

@ProviderFor(DriverEarningsController)
final driverEarningsControllerProvider = DriverEarningsControllerProvider._();

/// Today's earnings, read only while the driver is taking rides.
///
/// Going online triggers the fetch and going offline drops the figures, so an
/// offline driver is never shown a total that has since moved on. Finishing a
/// ride re-reads them, because that is the moment they change.
final class DriverEarningsControllerProvider
    extends $AsyncNotifierProvider<DriverEarningsController, DriverEarnings?> {
  /// Today's earnings, read only while the driver is taking rides.
  ///
  /// Going online triggers the fetch and going offline drops the figures, so an
  /// offline driver is never shown a total that has since moved on. Finishing a
  /// ride re-reads them, because that is the moment they change.
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
    r'8d4ea1dd74ee3d83b04968e9ee3f89a465dd6e68';

/// Today's earnings, read only while the driver is taking rides.
///
/// Going online triggers the fetch and going offline drops the figures, so an
/// offline driver is never shown a total that has since moved on. Finishing a
/// ride re-reads them, because that is the moment they change.

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

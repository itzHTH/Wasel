// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_earnings_overview_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(driverEarningsOverview)
final driverEarningsOverviewProvider = DriverEarningsOverviewProvider._();

final class DriverEarningsOverviewProvider
    extends
        $FunctionalProvider<
          DriverEarningsOverview,
          DriverEarningsOverview,
          DriverEarningsOverview
        >
    with $Provider<DriverEarningsOverview> {
  DriverEarningsOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverEarningsOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverEarningsOverviewHash();

  @$internal
  @override
  $ProviderElement<DriverEarningsOverview> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriverEarningsOverview create(Ref ref) {
    return driverEarningsOverview(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriverEarningsOverview value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriverEarningsOverview>(value),
    );
  }
}

String _$driverEarningsOverviewHash() =>
    r'a4bd87da1c1d768f91737f72f5912e90746d75d5';

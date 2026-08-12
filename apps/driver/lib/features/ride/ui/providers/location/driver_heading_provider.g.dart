// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_heading_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverHeading)
final driverHeadingProvider = DriverHeadingProvider._();

final class DriverHeadingProvider
    extends $NotifierProvider<DriverHeading, double> {
  DriverHeadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverHeadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverHeadingHash();

  @$internal
  @override
  DriverHeading create() => DriverHeading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$driverHeadingHash() => r'0383ee5b3ec8fb980b8bfc00e7d9560f58a96f42';

abstract class _$DriverHeading extends $Notifier<double> {
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

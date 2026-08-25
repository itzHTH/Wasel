// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earnings_range_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarningsRangeController)
final earningsRangeControllerProvider = EarningsRangeControllerProvider._();

final class EarningsRangeControllerProvider
    extends $NotifierProvider<EarningsRangeController, EarningsRange> {
  EarningsRangeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earningsRangeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earningsRangeControllerHash();

  @$internal
  @override
  EarningsRangeController create() => EarningsRangeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarningsRange value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarningsRange>(value),
    );
  }
}

String _$earningsRangeControllerHash() =>
    r'e7b13623fd42ae0df21e89541769c65bb8ea5d27';

abstract class _$EarningsRangeController extends $Notifier<EarningsRange> {
  EarningsRange build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<EarningsRange, EarningsRange>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EarningsRange, EarningsRange>,
              EarningsRange,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_location_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideLocationController)
final rideLocationControllerProvider = RideLocationControllerProvider._();

final class RideLocationControllerProvider
    extends $NotifierProvider<RideLocationController, bool> {
  RideLocationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideLocationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideLocationControllerHash();

  @$internal
  @override
  RideLocationController create() => RideLocationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$rideLocationControllerHash() =>
    r'1fd661e3e9b779404a22ad4cc1af95cda24b8dbe';

abstract class _$RideLocationController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

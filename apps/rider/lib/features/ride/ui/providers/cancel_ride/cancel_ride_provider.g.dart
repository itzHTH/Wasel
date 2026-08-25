// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_ride_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CancelRideController)
final cancelRideControllerProvider = CancelRideControllerProvider._();

final class CancelRideControllerProvider
    extends $AsyncNotifierProvider<CancelRideController, CancelRide?> {
  CancelRideControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelRideControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelRideControllerHash();

  @$internal
  @override
  CancelRideController create() => CancelRideController();
}

String _$cancelRideControllerHash() =>
    r'c44d4237af7ff1d3e6759a42f37ee705faaaa2b1';

abstract class _$CancelRideController extends $AsyncNotifier<CancelRide?> {
  FutureOr<CancelRide?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CancelRide?>, CancelRide?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CancelRide?>, CancelRide?>,
              AsyncValue<CancelRide?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

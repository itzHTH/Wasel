// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_ride_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RequestRideController)
final requestRideControllerProvider = RequestRideControllerProvider._();

final class RequestRideControllerProvider
    extends $AsyncNotifierProvider<RequestRideController, RequestRide?> {
  RequestRideControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestRideControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestRideControllerHash();

  @$internal
  @override
  RequestRideController create() => RequestRideController();
}

String _$requestRideControllerHash() =>
    r'3b649912819a1c47265566538d4dd4aec17eabcc';

abstract class _$RequestRideController extends $AsyncNotifier<RequestRide?> {
  FutureOr<RequestRide?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RequestRide?>, RequestRide?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RequestRide?>, RequestRide?>,
              AsyncValue<RequestRide?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

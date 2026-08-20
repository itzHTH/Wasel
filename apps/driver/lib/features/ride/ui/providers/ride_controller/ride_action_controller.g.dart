// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_action_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideActionController)
final rideActionControllerProvider = RideActionControllerProvider._();

final class RideActionControllerProvider
    extends $AsyncNotifierProvider<RideActionController, void> {
  RideActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideActionControllerHash();

  @$internal
  @override
  RideActionController create() => RideActionController();
}

String _$rideActionControllerHash() =>
    r'533bbd786231f393d739a34392d6fc6a617471c1';

abstract class _$RideActionController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

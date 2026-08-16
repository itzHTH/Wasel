// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RiderProfileController)
final riderProfileControllerProvider = RiderProfileControllerProvider._();

final class RiderProfileControllerProvider
    extends $AsyncNotifierProvider<RiderProfileController, RiderProfile?> {
  RiderProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: _noRetry,
        name: r'riderProfileControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderProfileControllerHash();

  @$internal
  @override
  RiderProfileController create() => RiderProfileController();
}

String _$riderProfileControllerHash() =>
    r'ef6ed1cfee1305f2ea921c31ca0405dad353d75c';

abstract class _$RiderProfileController extends $AsyncNotifier<RiderProfile?> {
  FutureOr<RiderProfile?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RiderProfile?>, RiderProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RiderProfile?>, RiderProfile?>,
              AsyncValue<RiderProfile?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

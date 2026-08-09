// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_camera_target_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initialCameraTarget)
final initialCameraTargetProvider = InitialCameraTargetProvider._();

final class InitialCameraTargetProvider
    extends $FunctionalProvider<AsyncValue<LatLng>, LatLng, FutureOr<LatLng>>
    with $FutureModifier<LatLng>, $FutureProvider<LatLng> {
  InitialCameraTargetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialCameraTargetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialCameraTargetHash();

  @$internal
  @override
  $FutureProviderElement<LatLng> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LatLng> create(Ref ref) {
    return initialCameraTarget(ref);
  }
}

String _$initialCameraTargetHash() =>
    r'57ec08b7d63b15b2a670b842a4f241b7f1b59196';

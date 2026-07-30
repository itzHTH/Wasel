// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_camera_moving_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsCameraMoving)
final isCameraMovingProvider = IsCameraMovingProvider._();

final class IsCameraMovingProvider
    extends $NotifierProvider<IsCameraMoving, bool> {
  IsCameraMovingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isCameraMovingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isCameraMovingHash();

  @$internal
  @override
  IsCameraMoving create() => IsCameraMoving();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isCameraMovingHash() => r'3058282764849e0abdc0362eba8304192709ad02';

abstract class _$IsCameraMoving extends $Notifier<bool> {
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

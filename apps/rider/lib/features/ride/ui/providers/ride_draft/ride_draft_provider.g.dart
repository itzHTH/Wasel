// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_draft_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// keepAlive: the draft must survive leaving and re-entering the screen
/// mid-flow; [reset] is the explicit way to discard it.

@ProviderFor(RideDraft)
final rideDraftProvider = RideDraftProvider._();

/// keepAlive: the draft must survive leaving and re-entering the screen
/// mid-flow; [reset] is the explicit way to discard it.
final class RideDraftProvider
    extends $NotifierProvider<RideDraft, RideDraftState> {
  /// keepAlive: the draft must survive leaving and re-entering the screen
  /// mid-flow; [reset] is the explicit way to discard it.
  RideDraftProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideDraftProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideDraftHash();

  @$internal
  @override
  RideDraft create() => RideDraft();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideDraftState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideDraftState>(value),
    );
  }
}

String _$rideDraftHash() => r'4b9504fbb78b8f40dca8521d9bb60cdf80c3ab73';

/// keepAlive: the draft must survive leaving and re-entering the screen
/// mid-flow; [reset] is the explicit way to discard it.

abstract class _$RideDraft extends $Notifier<RideDraftState> {
  RideDraftState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RideDraftState, RideDraftState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RideDraftState, RideDraftState>,
              RideDraftState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

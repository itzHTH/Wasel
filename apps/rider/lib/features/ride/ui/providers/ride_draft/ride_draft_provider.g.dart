// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_draft_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RideDraft)
final rideDraftProvider = RideDraftProvider._();

final class RideDraftProvider
    extends $NotifierProvider<RideDraft, RideDraftState> {
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

String _$rideDraftHash() => r'afb2f22d618113912d8dd04a1566947422473eac';

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

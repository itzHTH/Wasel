// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubmitProfile)
final submitProfileProvider = SubmitProfileProvider._();

final class SubmitProfileProvider
    extends $NotifierProvider<SubmitProfile, SubmitProfileState> {
  SubmitProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'submitProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$submitProfileHash();

  @$internal
  @override
  SubmitProfile create() => SubmitProfile();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SubmitProfileState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SubmitProfileState>(value),
    );
  }
}

String _$submitProfileHash() => r'89eebdfb0da54352cdd428c60d13a5ad30c0ee43';

abstract class _$SubmitProfile extends $Notifier<SubmitProfileState> {
  SubmitProfileState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SubmitProfileState, SubmitProfileState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SubmitProfileState, SubmitProfileState>,
              SubmitProfileState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

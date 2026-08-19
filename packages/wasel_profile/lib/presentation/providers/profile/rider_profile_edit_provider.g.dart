// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_profile_edit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RiderProfileEdit)
final riderProfileEditProvider = RiderProfileEditProvider._();

final class RiderProfileEditProvider
    extends $AsyncNotifierProvider<RiderProfileEdit, void> {
  RiderProfileEditProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riderProfileEditProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderProfileEditHash();

  @$internal
  @override
  RiderProfileEdit create() => RiderProfileEdit();
}

String _$riderProfileEditHash() => r'83f232f6eafb540abf77f4ae9bcd5708b1f8cdfa';

abstract class _$RiderProfileEdit extends $AsyncNotifier<void> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_profile_edit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DriverProfileEdit)
final driverProfileEditProvider = DriverProfileEditProvider._();

final class DriverProfileEditProvider
    extends $AsyncNotifierProvider<DriverProfileEdit, void> {
  DriverProfileEditProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driverProfileEditProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driverProfileEditHash();

  @$internal
  @override
  DriverProfileEdit create() => DriverProfileEdit();
}

String _$driverProfileEditHash() => r'0134c5f047dea8ffaecfe28786b006e10087f641';

abstract class _$DriverProfileEdit extends $AsyncNotifier<void> {
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

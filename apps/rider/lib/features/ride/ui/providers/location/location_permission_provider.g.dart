// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_permission_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationPermission)
final locationPermissionProvider = LocationPermissionProvider._();

final class LocationPermissionProvider
    extends $AsyncNotifierProvider<LocationPermission, LocationAccess> {
  LocationPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPermissionHash();

  @$internal
  @override
  LocationPermission create() => LocationPermission();
}

String _$locationPermissionHash() =>
    r'94450e81be7663fecd483170fdc7f9af0f100588';

abstract class _$LocationPermission extends $AsyncNotifier<LocationAccess> {
  FutureOr<LocationAccess> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LocationAccess>, LocationAccess>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocationAccess>, LocationAccess>,
              AsyncValue<LocationAccess>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

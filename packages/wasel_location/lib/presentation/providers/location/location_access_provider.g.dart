// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_access_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Manages the global location permission state and handles prompting.
//
//? - Uses [AsyncNotifier] to provide a loading state during the initial read,
//?   while allowing state mutations via the [request] action.
//
//? - Kept alive (`keepAlive: true`) because permission is a device-wide truth,
//?   preventing unnecessary loading flickers during screen navigation.
//
//? - Delegates the actual UI prompting to the core `permission_gate` while
//?   relying on `DeviceLocationRepo` for the authoritative state read.

@ProviderFor(LocationAccessController)
final locationAccessControllerProvider = LocationAccessControllerProvider._();

/// Manages the global location permission state and handles prompting.
//
//? - Uses [AsyncNotifier] to provide a loading state during the initial read,
//?   while allowing state mutations via the [request] action.
//
//? - Kept alive (`keepAlive: true`) because permission is a device-wide truth,
//?   preventing unnecessary loading flickers during screen navigation.
//
//? - Delegates the actual UI prompting to the core `permission_gate` while
//?   relying on `DeviceLocationRepo` for the authoritative state read.
final class LocationAccessControllerProvider
    extends $AsyncNotifierProvider<LocationAccessController, LocationAccess> {
  /// Manages the global location permission state and handles prompting.
  //
  //? - Uses [AsyncNotifier] to provide a loading state during the initial read,
  //?   while allowing state mutations via the [request] action.
  //
  //? - Kept alive (`keepAlive: true`) because permission is a device-wide truth,
  //?   preventing unnecessary loading flickers during screen navigation.
  //
  //? - Delegates the actual UI prompting to the core `permission_gate` while
  //?   relying on `DeviceLocationRepo` for the authoritative state read.
  LocationAccessControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationAccessControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationAccessControllerHash();

  @$internal
  @override
  LocationAccessController create() => LocationAccessController();
}

String _$locationAccessControllerHash() =>
    r'7cb561b96012ebec1b61a42e209824d6e42c9383';

/// Manages the global location permission state and handles prompting.
//
//? - Uses [AsyncNotifier] to provide a loading state during the initial read,
//?   while allowing state mutations via the [request] action.
//
//? - Kept alive (`keepAlive: true`) because permission is a device-wide truth,
//?   preventing unnecessary loading flickers during screen navigation.
//
//? - Delegates the actual UI prompting to the core `permission_gate` while
//?   relying on `DeviceLocationRepo` for the authoritative state read.

abstract class _$LocationAccessController
    extends $AsyncNotifier<LocationAccess> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_type.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Defaults to [AuthUserType.rider]. The driver app overrides this once at its
/// root `ProviderScope` with [AuthUserType.driver], which is all that's needed
/// to point the shared registration flow at the driver endpoints.

@ProviderFor(authUserType)
final authUserTypeProvider = AuthUserTypeProvider._();

/// Defaults to [AuthUserType.rider]. The driver app overrides this once at its
/// root `ProviderScope` with [AuthUserType.driver], which is all that's needed
/// to point the shared registration flow at the driver endpoints.

final class AuthUserTypeProvider
    extends $FunctionalProvider<AuthUserType, AuthUserType, AuthUserType>
    with $Provider<AuthUserType> {
  /// Defaults to [AuthUserType.rider]. The driver app overrides this once at its
  /// root `ProviderScope` with [AuthUserType.driver], which is all that's needed
  /// to point the shared registration flow at the driver endpoints.
  AuthUserTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authUserTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authUserTypeHash();

  @$internal
  @override
  $ProviderElement<AuthUserType> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthUserType create(Ref ref) {
    return authUserType(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthUserType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthUserType>(value),
    );
  }
}

String _$authUserTypeHash() => r'401a145a323f1cfee2014a8a871a4cbb4be1d2c6';

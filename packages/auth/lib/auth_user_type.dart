import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_user_type.g.dart';

/// Which side of the platform is registering. The value maps to the URL segment
/// used by the role-specific registration endpoints
/// (`/api/v1/Auth/{userType}/...`). Login and logout are shared and ignore it.
enum AuthUserType {
  rider('rider'),
  driver('driver');

  const AuthUserType(this.path);

  /// Path segment substituted into the registration endpoints.
  final String path;
}

/// Defaults to [AuthUserType.rider]. The driver app overrides this once at its
/// root `ProviderScope` with [AuthUserType.driver], which is all that's needed
/// to point the shared registration flow at the driver endpoints.
@riverpod
AuthUserType authUserType(Ref ref) => AuthUserType.rider;

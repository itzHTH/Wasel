import 'package:wasel_auth/auth_user_type.dart';

/// Decides whether an account may sign in to the app it is authenticating
/// against. Login is shared between the rider and driver apps, so without this
/// a driver account would be accepted by the rider app and vice versa.
abstract final class AuthRolePolicy {
  static const String riderRole = 'Rider';
  static const String driverRole = 'Driver';

  static const String deniedMessage =
      'هذا الحساب غير مصرح له بالدخول لهذا التطبيق';

  static String roleOf(AuthUserType userType) => switch (userType) {
    AuthUserType.rider => riderRole,
    AuthUserType.driver => driverRole,
  };

  static bool isAllowed(List<String> roles, AuthUserType userType) =>
      roles.contains(roleOf(userType));
}

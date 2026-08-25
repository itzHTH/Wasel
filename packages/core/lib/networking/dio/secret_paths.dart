abstract final class ApiSecretPaths {
  static const List<String> paths = [
    '/Payments/',
    '/Auth/login',
    '/Auth/reset-password',
    '/Auth/refresh-token',
    '/Auth/revoke-token',
    '/complete-registration',
  ];

  static bool carries(String path) => paths.any(path.contains);
}

import 'package:wasal/flavors/flavors_config.dart';

class ApiConstants {
  static String get baseUrl => FlavorConfig.instance.baseUrl;
  static const String apiVersion = '1.0';
  static const String acceptEncoding = 'br';

  // Auth
  static const String login = '/api/v1/Auth/login';
  static const String initiateRegistration =
      '/api/v1/Auth/rider/initiate-registration';
  static const String verifyRegistration =
      '/api/v1/Auth/rider/verify-registration';
  static const String refreshToken = '/api/v1/Auth/refresh-token';
  static const String revokeToken = '/api/v1/Auth/revoke-token';
  static const String forgotPassword = '/api/v1/Auth/forgot-password';
  static const String resetPassword = '/api/v1/Auth/reset-password';

  //
}

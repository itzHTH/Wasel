import 'package:wasel_core/flavors/flavors_config.dart';

class ApiConstants {
  static String get baseUrl => FlavorConfig.instance.baseUrl;
  static const String googleGeocodingBaseUrl =
      'https://geocode.googleapis.com/v4';
  static String get hubUrl => "https://apiservice.ddns.net/wasl/hubs/tracking";

  static const String apiVersion = '1.0';
  static const String acceptEncoding = 'br';

  // Auth General (shared across rider & driver)
  static const String login = '/api/v1/Auth/login';
  static const String refreshToken = '/api/v1/Auth/refresh-token';
  static const String revokeToken = '/api/v1/Auth/revoke-token';
  static const String forgotPassword = '/api/v1/Auth/forgot-password';
  static const String verifyResetOtp = '/api/v1/Auth/verify-reset-otp';
  static const String resetPassword = '/api/v1/Auth/reset-password';

  // Registration — the `{userType}` segment ('rider' | 'driver') is substituted
  // by Retrofit via @Path('userType'); the value comes from AuthUserType.
  static const String initiateRegistration =
      '/api/v1/Auth/{userType}/initiate-registration';
  static const String verifyOtp = '/api/v1/Auth/{userType}/verify-otp';
  static const String completeRegistration =
      '/api/v1/Auth/{userType}/complete-registration';
}

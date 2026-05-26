import 'package:wasal/flavors/flavors_config.dart';

class ApiConstants {
  static String get baseUrl => FlavorConfig.instance.baseUrl;
  static const String apiVersion = '1.0';
  static const String acceptEncoding = 'br';

  // Auth
  static const String login = '/auth/login';

  //
}

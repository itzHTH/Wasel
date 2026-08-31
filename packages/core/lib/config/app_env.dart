abstract final class AppEnv {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String hubUrl = String.fromEnvironment('HUB_URL');
  static const String searchApiKey = String.fromEnvironment('SEARCH_API_KEY');
  static const String routesApiKey = String.fromEnvironment('ROUTES_API_KEY');

  static void ensureConfigured() {
    final missing = <String>[
      if (baseUrl.isEmpty) 'BASE_URL',
      if (hubUrl.isEmpty) 'HUB_URL',
      if (searchApiKey.isEmpty) 'SEARCH_API_KEY',
      if (routesApiKey.isEmpty) 'ROUTES_API_KEY',
    ];

    if (missing.isNotEmpty) {
      throw StateError(
        'Missing environment values: ${missing.join(', ')}. '
        'Pass --dart-define-from-file for the root env file and the app '
        'env.keys.json (see README → Environment setup).',
      );
    }
  }
}

enum Flavor { production, development }

class FlavorConfig {
  final Flavor flavor;
  final String appName;
  final String baseUrl;

  FlavorConfig._({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
  });

  static FlavorConfig? _instance;
  factory FlavorConfig({
    required Flavor flavor,
    required String appName,
    required String baseUrl,
  }) {
    _instance ??= FlavorConfig._(
      flavor: flavor,
      appName: appName,
      baseUrl: baseUrl,
    );
    return _instance!;
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception("FlavorConfig not initialized");
    }
    return _instance!;
  }

  bool isProduction() => flavor == Flavor.production;
  bool isDevelopment() => flavor == Flavor.development;
}

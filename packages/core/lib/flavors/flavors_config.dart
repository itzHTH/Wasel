enum Flavor { production, development }

class FlavorConfig {
  final Flavor flavor;
  final String appName;

  FlavorConfig._({required this.flavor, required this.appName});

  static FlavorConfig? _instance;
  factory FlavorConfig({required Flavor flavor, required String appName}) {
    _instance ??= FlavorConfig._(flavor: flavor, appName: appName);
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

import 'package:flutter/material.dart';
import 'package:wasal/flavors/flavors_config.dart';
import 'package:wasal/wasal_app.dart';

void mainCommon({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  FlavorConfig(flavor: flavor, appName: appName, baseUrl: baseUrl);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const WasalApp());
}

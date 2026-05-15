import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasal/firebase_options.dart';
import 'package:wasal/flavors/flavors_config.dart';
import 'package:wasal/wasal_app.dart';

void mainCommon({
  required Flavor flavor,
  required String appName,
  required String baseUrl,
}) async {
  FlavorConfig(flavor: flavor, appName: appName, baseUrl: baseUrl);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const WasalApp());
}

import 'package:flutter/material.dart';
import 'package:wasal/features/splash/ui/screens/splash_screen.dart';

class WasalApp extends StatelessWidget {
  const WasalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

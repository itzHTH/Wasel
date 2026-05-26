import 'package:flutter/material.dart';
import 'package:wasal/features/splash/ui/screens/spalsh_screen.dart';
import 'package:wasal/flavors/flavors_config.dart';

class WasalApp extends StatelessWidget {
  const WasalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpalshScreen(),
    );
  }
}

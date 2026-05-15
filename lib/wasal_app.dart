import 'package:flutter/material.dart';
import 'package:wasal/flavors/flavors_config.dart';

class WasalApp extends StatelessWidget {
  const WasalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: Text('Wasel ${FlavorConfig.instance.flavor}')),
      ),
    );
  }
}

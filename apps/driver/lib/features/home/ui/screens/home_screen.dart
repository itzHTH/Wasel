import 'package:flutter/material.dart';

/// Placeholder driver home. Real driver home (and logout, mirroring the rider)
/// is built on top of the shared logic in later work.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية — السائق')),
      body: const Center(
        child: Text('مرحباً بك في تطبيق السائق', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

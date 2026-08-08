import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class NavigationFab extends StatelessWidget {
  const NavigationFab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'driver_navigation_fab',
      backgroundColor: AppColor.primary500,
      shape: const CircleBorder(),
      onPressed: onTap,
      child: Icon(
        Icons.navigation_rounded,
        size: AppDimens.icon24,
        color: AppColor.neutral0,
      ),
    );
  }
}

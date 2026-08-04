import 'package:driver/core/const/app_driver_consts.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideScreen extends StatelessWidget {
  const RideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        AppMap(mapId: AppDriverConsts.mapStyleID),
        Positioned.fill(child: AppMapLoadingOverlay()),
      ],
    );
  }
}

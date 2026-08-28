import 'package:flutter/material.dart';
import 'package:wasal/core/consts/app_icons.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:wasel_core/wasel_core.dart';

class RideRecoveryOverlay extends StatelessWidget {
  const RideRecoveryOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlockingLoader(
      logoAsset: AppIcons.logo,
      message: context.l10n.restoringRide,
    );
  }
}

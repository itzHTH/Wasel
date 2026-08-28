import 'package:driver/core/const/app_driver_consts.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideRecoveryOverlay extends StatelessWidget {
  const RideRecoveryOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlockingLoader(
      logoAsset: AppDriverConsts.logoIcon,
      message: context.l10n.restoringRide,
    );
  }
}

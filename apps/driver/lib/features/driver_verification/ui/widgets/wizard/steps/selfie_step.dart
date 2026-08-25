import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/upload_card.dart';

class SelfieStep extends StatelessWidget {
  final ValueListenable<XFile?> selfie;
  final VoidCallback onTap;

  const SelfieStep({super.key, required this.selfie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          Text(
            context.l10n.takeClearSelfie,
            style: context.styles.bodyMuted(),
          ),
          SizedBox(height: AppDimens.space24),
          ValueListenableBuilder<XFile?>(
            valueListenable: selfie,
            builder: (context, file, _) => UploadCard(
              label: context.l10n.selfiePhoto,
              icon: Icons.face_outlined,
              file: file,
              onTap: onTap,
            ),
          ),
          SizedBox(height: AppDimens.space24),
        ],
      ),
    );
  }
}

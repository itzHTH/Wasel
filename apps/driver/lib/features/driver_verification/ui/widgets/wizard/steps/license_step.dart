import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/upload_card.dart';

class LicenseStep extends StatelessWidget {
  final ValueListenable<XFile?> front;
  final ValueListenable<XFile?> back;
  final VoidCallback onTapFront;
  final VoidCallback onTapBack;

  const LicenseStep({
    super.key,
    required this.front,
    required this.back,
    required this.onTapFront,
    required this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimens.space24),
          Text(
            context.l10n.photographLicense,
            style: context.styles.bodyMuted(),
          ),
          SizedBox(height: AppDimens.space24),
          ValueListenableBuilder<XFile?>(
            valueListenable: front,
            builder: (context, file, _) => UploadCard(
              label: context.l10n.licenseFront,
              file: file,
              onTap: onTapFront,
            ),
          ),
          SizedBox(height: AppDimens.space16),
          ValueListenableBuilder<XFile?>(
            valueListenable: back,
            builder: (context, file, _) => UploadCard(
              label: context.l10n.licenseBack,
              file: file,
              onTap: onTapBack,
            ),
          ),
          SizedBox(height: AppDimens.space24),
        ],
      ),
    );
  }
}

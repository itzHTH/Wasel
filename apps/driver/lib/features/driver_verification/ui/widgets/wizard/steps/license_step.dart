import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/upload_card.dart';

/// Wizard step 1 — driver's license: front then back capture slots.
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
            'صوّر رخصة القيادة من الأمام والخلف داخل الإطار.',
            style: AppTextStyles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space24),
          ValueListenableBuilder<XFile?>(
            valueListenable: front,
            builder: (context, file, _) => UploadCard(
              label: 'الوجه الأمامي للرخصة',
              file: file,
              onTap: onTapFront,
            ),
          ),
          SizedBox(height: AppDimens.space16),
          ValueListenableBuilder<XFile?>(
            valueListenable: back,
            builder: (context, file, _) => UploadCard(
              label: 'الوجه الخلفي للرخصة',
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

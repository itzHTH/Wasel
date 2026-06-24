import 'package:camera/camera.dart' show XFile;
import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/driver_verification/ui/widgets/upload_card.dart';

/// Wizard step 3 — selfie: a single face-capture slot.
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
            'التقط صورة شخصية واضحة لمطابقة هويتك.',
            style: AppTextStyles.font14Neutral400Regular,
          ),
          SizedBox(height: AppDimens.space24),
          ValueListenableBuilder<XFile?>(
            valueListenable: selfie,
            builder: (context, file, _) => UploadCard(
              label: 'صورة شخصية',
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

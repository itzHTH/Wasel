import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/captured_image.dart';

/// Shows the just-captured [file] large with confirm / retake actions.
///
/// Returns `true` when the user accepts the capture, and `false`/`null` when
/// they choose to retake or dismiss the sheet.
Future<bool?> showCapturePreviewSheet({
  required BuildContext context,
  required XFile file,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor.neutral0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (context) => _CapturePreviewSheet(file: file),
  );
}

class _CapturePreviewSheet extends StatelessWidget {
  final XFile file;

  const _CapturePreviewSheet({required this.file});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.screenHPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'تأكيد الصورة',
              style: AppTextStyles.font20Secondary900Bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimens.space8),
            Text(
              'تأكد أن الصورة واضحة ومقروءة قبل المتابعة.',
              style: AppTextStyles.font14Neutral400Regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimens.space24),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radius16),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 360.h),
                child: CapturedImage(file: file, fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: AppDimens.space24),
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: SizedBox(
                    height: AppDimens.buttonHeight,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColor.neutral200,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusPill,
                          ),
                        ),
                      ),
                      child: Text(
                        'إعادة الالتقاط',
                        style: AppTextStyles.font14Secondary900SemiBold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: AuthPrimaryButton(
                    label: 'تأكيد',
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

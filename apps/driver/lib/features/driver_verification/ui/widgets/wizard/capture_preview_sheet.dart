import 'package:wasel_auth/wasel_auth.dart';
import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/captured_image.dart';

Future<bool?> showCapturePreviewSheet({
  required BuildContext context,
  required XFile file,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: context.colors.neutral0,
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
              context.l10n.confirmPhoto,
              style: context.styles.font20Secondary900Bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppDimens.space8),
            Text(
              context.l10n.ensurePhotoClear,
              style: context.styles.font14Neutral400Regular,
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
                          color: context.colors.neutral200,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimens.radiusPill,
                          ),
                        ),
                      ),
                      child: Text(
                        context.coreL10n.cancel,
                        style: context.styles.font14Secondary900SemiBold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppDimens.space12),
                Expanded(
                  child: AuthPrimaryButton(
                    label: context.coreL10n.confirm,
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

import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// Where a capture slot should source its image from.
enum CaptureSource { camera, gallery }

/// Bottom sheet offering camera vs. gallery. Returns the chosen [CaptureSource],
/// or `null` if the sheet is dismissed.
Future<CaptureSource?> showCaptureSourceSheet({required BuildContext context}) {
  return showModalBottomSheet<CaptureSource>(
    context: context,
    backgroundColor: AppColor.neutral0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
    ),
    builder: (context) => const _CaptureSourceSheet(),
  );
}

class _CaptureSourceSheet extends StatelessWidget {
  const _CaptureSourceSheet();

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
              'اختر مصدر الصورة',
              textAlign: TextAlign.center,
              style: AppTextStyles.font20Secondary900Bold,
            ),
            SizedBox(height: AppDimens.space24),
            _SourceTile(
              icon: Icons.photo_camera_outlined,
              label: 'التقاط بالكاميرا',
              onTap: () => Navigator.of(context).pop(CaptureSource.camera),
            ),
            SizedBox(height: AppDimens.space12),
            _SourceTile(
              icon: Icons.photo_library_outlined,
              label: 'اختيار من المعرض',
              onTap: () => Navigator.of(context).pop(CaptureSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SourceTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radius16),
      child: Container(
        padding: EdgeInsets.all(AppDimens.space16),
        decoration: BoxDecoration(
          color: AppColor.neutral50,
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          border: Border.all(color: AppColor.neutral200),
        ),
        child: Row(
          children: [
            Icon(icon, size: AppDimens.icon24, color: AppColor.primary500),
            SizedBox(width: AppDimens.space16),
            Text(label, style: AppTextStyles.font16Secondary500Regular),
          ],
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/captured_image.dart';

/// A tappable capture slot used across the verification wizard.
///
/// Two states: an empty placeholder (camera icon + label) and a captured
/// thumbnail with a retake affordance. Tapping always re-runs [onTap] — opening
/// the capture flow whether the slot is empty or being retaken.
class UploadCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final XFile? file;
  final VoidCallback onTap;

  const UploadCard({
    super.key,
    required this.label,
    required this.file,
    required this.onTap,
    this.icon = Icons.photo_camera_outlined,
  });

  bool get _isFilled => file != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: _isFilled ? AppColor.neutral0 : AppColor.neutral50,
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          border: Border.all(
            color: _isFilled ? AppColor.primary300 : AppColor.neutral200,
            width: 1.5,
          ),
        ),
        child: _isFilled ? _buildThumbnail() : _buildEmpty(),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimens.icon36, color: AppColor.neutral400),
          SizedBox(height: AppDimens.space8),
          Text(label, style: AppTextStyles.font14Neutral400Regular),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      fit: StackFit.expand,
      children: [
        CapturedImage(file: file!),
        // Bottom retake strip.
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.space12,
              vertical: AppDimens.space8,
            ),
            color: AppColor.secondary900.withValues(alpha: 0.55),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh_rounded,
                  size: AppDimens.icon18,
                  color: AppColor.neutral0,
                ),
                SizedBox(width: AppDimens.space8),
                Text(
                  'إعادة الالتقاط',
                  style: AppTextStyles.font16Neutral0SemiBold,
                ),
              ],
            ),
          ),
        ),
        // Filled badge.
        PositionedDirectional(
          top: AppDimens.space8,
          end: AppDimens.space8,
          child: Icon(
            Icons.check_circle_rounded,
            size: AppDimens.icon24,
            color: AppColor.primary500,
          ),
        ),
      ],
    );
  }
}

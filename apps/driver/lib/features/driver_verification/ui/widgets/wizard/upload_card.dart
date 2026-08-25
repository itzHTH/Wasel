import 'package:camera/camera.dart' show XFile;
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:driver/features/driver_verification/ui/widgets/wizard/captured_image.dart';

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
          color: _isFilled ? context.colors.neutral0 : context.colors.neutral50,
          borderRadius: BorderRadius.circular(context.shape.radiusCard),
          border: Border.all(
            color: _isFilled
                ? context.colors.primary300
                : context.colors.neutral200,
            width: 1.5,
          ),
        ),
        child: _isFilled
            ? FileThumbnail(file: file!)
            : EmptyThumbnail(icon: icon, label: label),
      ),
    );
  }
}

class EmptyThumbnail extends StatelessWidget {
  const EmptyThumbnail({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimens.icon36, color: context.colors.neutral400),
          SizedBox(height: AppDimens.space8),
          Text(label, style: context.styles.bodyMuted()),
        ],
      ),
    );
  }
}

class FileThumbnail extends StatelessWidget {
  const FileThumbnail({super.key, required this.file});

  final XFile file;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CapturedImage(file: file),
        // Bottom retake strip.
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.space12,
              vertical: AppDimens.space8,
            ),
            color: context.colors.scrim.withValues(alpha: 0.55),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.refresh_rounded,
                  size: AppDimens.icon18,
                  color: context.colors.onScrim,
                ),
                SizedBox(width: AppDimens.space8),
                Text(
                  context.l10n.retake,
                  style: context.styles.bodyLarge(
                    weight: FontWeight.w600,
                    color: context.colors.onScrim,
                  ),
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
            color: context.colors.primary500,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

/// A general-purpose, themed dialog for the Wasel apps.
///
/// Use it anywhere you need a centered confirm/cancel prompt: permission
/// rationales, destructive confirmations, info notices, etc. It only renders and
/// reports the user's choice — callers own the side effect of each action.
///
/// [show] returns `true` when the confirm action is tapped, `false` when the
/// dialog is cancelled or dismissed. When [cancelLabel] is null only the confirm
/// action is shown.
class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final String confirmLabel;
  final String? cancelLabel;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.icon,
    this.cancelLabel,
  });

  /// Shows the dialog. Returns `true` if the confirm action was tapped.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    IconData? icon,
    String? cancelLabel,
    bool barrierDismissible = true,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AppDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        icon: icon,
        cancelLabel: cancelLabel,
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.neutral0,
      insetPadding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radius24),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimens.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (icon != null) ...[
              Align(
                child: Container(
                  width: 56.r,
                  height: 56.r,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primary100,
                  ),
                  child: Icon(
                    icon,
                    size: AppDimens.icon24,
                    color: AppColor.primary500,
                  ),
                ),
              ),
              SizedBox(height: AppDimens.space16),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.font20Secondary900Bold,
            ),
            SizedBox(height: AppDimens.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Secondary500Regular,
            ),
            SizedBox(height: AppDimens.space24),
            SizedBox(
              height: AppDimens.buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary500,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radius12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  confirmLabel,
                  style: AppTextStyles.font16Neutral0SemiBold,
                ),
              ),
            ),
            if (cancelLabel != null) ...[
              SizedBox(height: AppDimens.space8),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelLabel!,
                    style: AppTextStyles.font14Primary500SemiBold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

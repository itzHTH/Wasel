import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// A general-purpose, themed dialog for the Wasel apps.
class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData? icon;
  final String confirmLabel;
  final String? cancelLabel;
  final bool isDestructive;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.icon,
    this.cancelLabel,
    this.isDestructive = false,
  });

  /// Shows the dialog. Returns `true` if the confirm action was tapped.
  ///
  /// Set [isDestructive] for irreversible actions: the confirm action and the
  /// icon switch to the error palette.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    IconData? icon,
    String? cancelLabel,
    bool barrierDismissible = true,
    bool isDestructive = false,
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
        isDestructive: isDestructive,
      ),
    );
    return confirmed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.elementBackground,
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDestructive
                        ? context.colors.alertError100
                        : context.colors.primary100,
                  ),
                  child: Icon(
                    icon,
                    size: AppDimens.icon24,
                    color: isDestructive
                        ? context.colors.alertError700
                        : context.colors.primary500,
                  ),
                ),
              ),
              SizedBox(height: AppDimens.space16),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.styles.font20Secondary900Bold,
            ),
            SizedBox(height: AppDimens.space8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.styles.font16Secondary500Regular,
            ),
            SizedBox(height: AppDimens.space24),
            SizedBox(
              height: AppDimens.buttonHeight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDestructive
                      ? context.colors.alertError700
                      : context.colors.primary500,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radius12),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  confirmLabel,
                  style: context.styles.font16Neutral0SemiBold,
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
                    style: isDestructive
                        ? context.styles.font14Secondary900SemiBold
                        : context.styles.font14Primary500SemiBold,
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

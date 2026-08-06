import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

class RideCardShell extends StatelessWidget {
  const RideCardShell({
    super.key,
    required this.children,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.secondaryStyle,
  });

  final List<Widget> children;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final TextStyle? secondaryStyle;

  @override
  Widget build(BuildContext context) {
    final secondaryLabel = this.secondaryLabel;
    final onSecondary = this.onSecondary;

    return Material(
      color: AppColor.elementBackground,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppDimens.radius24),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(AppDimens.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...children,
              SizedBox(height: AppDimens.space32),
              SizedBox(
                height: AppDimens.buttonHeight,
                child: ElevatedButton(
                  onPressed: onPrimary,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary500,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                  child: Text(
                    primaryLabel,
                    style: AppTextStyles.font16Neutral0SemiBold,
                  ),
                ),
              ),
              if (secondaryLabel != null && onSecondary != null) ...[
                SizedBox(height: AppDimens.space12),
                SizedBox(
                  height: AppDimens.buttonHeight,
                  child: OutlinedButton(
                    onPressed: onSecondary,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.neutral200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimens.radiusPill,
                        ),
                      ),
                    ),
                    child: Text(
                      secondaryLabel,
                      style:
                          secondaryStyle ??
                          AppTextStyles.font14Secondary500Medium,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

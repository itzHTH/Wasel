import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasal/core/theme/app_color.dart';
import 'package:wasal/core/theme/app_dimens.dart';
import 'package:wasal/core/theme/app_text_styles.dart';

class AuthTabSwitcher extends StatelessWidget {
  final bool isLoginSelected;
  final ValueChanged<bool> onTabChanged;

  const AuthTabSwitcher({
    super.key,
    required this.isLoginSelected,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.tabBarHeight,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColor.neutral100,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      ),
      // LayoutBuilder gives us the exact inner width/height after padding
      child: LayoutBuilder(
        builder: (context, constraints) {
          final pillWidth = constraints.maxWidth / 2;
          final pillHeight = constraints.maxHeight;

          return Stack(
            children: [
              // Single sliding pill — one widget, one animation, no visual gap
              AnimatedAlign(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeInOut,
                // In RTL: first Row child is on the RIGHT (login), second on the LEFT (register)
                alignment: isLoginSelected
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: _SlidingPill(width: pillWidth, height: pillHeight),
              ),
              // Labels sit on top of the pill — transparent background
              Row(
                children: [
                  _TabLabel(
                    label: 'تسجيل الدخول',
                    isSelected: isLoginSelected,
                    onTap: () => onTabChanged(true),
                  ),
                  _TabLabel(
                    label: 'تسجيل',
                    isSelected: !isLoginSelected,
                    onTap: () => onTabChanged(false),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SlidingPill extends StatelessWidget {
  final double width;
  final double height;

  const _SlidingPill({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.neutral0,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        boxShadow: [
          BoxShadow(
            color: AppColor.secondary900.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabLabel({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOut,
            style: isSelected
                ? AppTextStyles.font14Secondary900SemiBold
                : AppTextStyles.font14Neutral400Medium,
            child: Text(label),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';

class ManualCaptureButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const ManualCaptureButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Semantics(
      button: true,
      label: 'التقاط',
      child: GestureDetector(
        onTap: onPressed,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.neutral0, width: 4),
            ),
            child: Padding(
              padding: EdgeInsets.all(4.r),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.neutral0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

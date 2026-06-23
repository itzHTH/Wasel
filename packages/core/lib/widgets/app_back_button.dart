import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Container(
          width: 40.r,
          height: 40.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.neutral200, width: 1.5),
          ),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Icon(
              Icons.arrow_forward_rounded,
              size: AppDimens.icon20,
              color: AppColor.secondary900,
            ),
          ),
        ),
      ),
    );
  }
}

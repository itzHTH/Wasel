import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class VerificationStatusBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;

  const VerificationStatusBadge({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.r,
      height: 88.r,
      decoration: BoxDecoration(shape: BoxShape.circle, color: background),
      child: Icon(icon, color: color, size: AppDimens.icon36),
    );
  }
}

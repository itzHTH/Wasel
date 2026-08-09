import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

/// The icon + title (+ optional subtitle) line every in-ride card opens with.
class CardStageHeader extends StatelessWidget {
  const CardStageHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.tint = AppColor.primary500,
    this.background = AppColor.primary100,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color tint;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimens.space8),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ),
          child: Icon(icon, size: AppDimens.icon20, color: tint),
        ),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.font20Secondary900Bold),
              if (subtitle != null)
                Text(subtitle, style: AppTextStyles.font14Neutral400Regular),
            ],
          ),
        ),
      ],
    );
  }
}

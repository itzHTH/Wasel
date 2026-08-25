import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/ride/ride_stage_badge.dart';

/// The status badge + title (+ optional subtitle) line every ride card opens
/// with, on both sides of the platform.
class RideStageHeader extends StatelessWidget {
  const RideStageHeader({
    super.key,
    required this.stage,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final RideStageVisual stage;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    final trailing = this.trailing;

    return Row(
      children: [
        RideStageBadge(stage: stage),
        SizedBox(width: AppDimens.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.styles.title()),
              if (subtitle != null)
                Text(subtitle, style: context.styles.bodyMuted()),
            ],
          ),
        ),
        if (trailing != null) ...[SizedBox(width: AppDimens.space12), trailing],
      ],
    );
  }
}

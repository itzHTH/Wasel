import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppStat {
  const AppStat({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.valueTextDirection,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final TextDirection? valueTextDirection;
}

class AppStatStrip extends StatelessWidget {
  const AppStatStrip({super.key, required this.stats});

  final List<AppStat> stats;

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[];
    for (var i = 0; i < stats.length; i++) {
      if (i > 0) {
        cells.add(
          const VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColor.neutral200,
          ),
        );
      }
      cells.add(Expanded(child: _AppStatCell(stat: stats[i])));
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cells,
      ),
    );
  }
}

class _AppStatCell extends StatelessWidget {
  const _AppStatCell({required this.stat});

  final AppStat stat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(stat.icon, size: AppDimens.icon18, color: stat.iconColor),
              SizedBox(width: AppDimens.space4),
              Flexible(
                child: Text(
                  stat.value,
                  textDirection: stat.valueTextDirection,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Secondary900SemiBold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            stat.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font12Neutral400Regular,
          ),
        ],
      ),
    );
  }
}

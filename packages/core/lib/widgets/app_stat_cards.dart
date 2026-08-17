import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';

class AppStat {
  const AppStat({
    required this.icon,
    required this.iconColor,
    required this.background,
    required this.label,
    required this.value,
    this.valueTextDirection,
  });

  final IconData icon;
  final Color iconColor;
  final Color background;
  final String label;
  final String value;
  final TextDirection? valueTextDirection;
}

class AppStatCards extends StatelessWidget {
  const AppStatCards({super.key, required this.stats});

  final List<AppStat> stats;

  @override
  Widget build(BuildContext context) {
    final cards = <Widget>[];
    for (var i = 0; i < stats.length; i++) {
      if (i > 0) cards.add(SizedBox(width: AppDimens.space12));
      cards.add(Expanded(child: _AppStatCard(stat: stats[i])));
    }

    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: cards);
  }
}

class _AppStatCard extends StatelessWidget {
  const _AppStatCard({required this.stat});

  final AppStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.space12,
        vertical: AppDimens.space12,
      ),
      decoration: BoxDecoration(
        color: stat.background,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(stat.icon, size: AppDimens.icon18, color: stat.iconColor),
              SizedBox(width: AppDimens.space4),
              Expanded(
                child: Text(
                  stat.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Neutral600SemiBold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.space4),
          Text(
            stat.value,
            textDirection: stat.valueTextDirection,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font16Secondary900Bold,
          ),
        ],
      ),
    );
  }
}

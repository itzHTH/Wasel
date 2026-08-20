import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_entrance_fade.dart';

class RideHistoryEmptyState extends StatelessWidget {
  const RideHistoryEmptyState({super.key, required this.onRefresh});

  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    // Kept scrollable so pull-to-refresh still works on an empty account.
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: context.colors.primary500,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: AppEntranceFade(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.space32,
                    vertical: AppDimens.space48,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 96.r,
                        height: 96.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colors.primary100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.route_rounded,
                          size: AppDimens.icon48,
                          color: context.colors.primary500,
                        ),
                      ),
                      SizedBox(height: AppDimens.space24),
                      Text(
                        'لا توجد رحلات بعد',
                        textAlign: TextAlign.center,
                        style: context.styles.font20Secondary900Bold,
                      ),
                      SizedBox(height: AppDimens.space8),
                      Text(
                        'ستظهر هنا رحلاتك المكتملة والملغاة فور انتهائها.',
                        textAlign: TextAlign.center,
                        style: context.styles.font14Neutral400Regular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

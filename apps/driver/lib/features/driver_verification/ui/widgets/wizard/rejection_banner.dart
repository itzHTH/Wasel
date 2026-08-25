import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class RejectionBanner extends StatelessWidget {
  final String reason;

  const RejectionBanner({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppDimens.space12),
      decoration: BoxDecoration(
        color: context.colors.alertError100,
        borderRadius: BorderRadius.circular(AppDimens.radius12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: context.colors.alertError500,
            size: AppDimens.icon20,
          ),
          SizedBox(width: AppDimens.space8),
          Expanded(
            child: Text(
              reason,
              style: context.styles
                  .body(weight: FontWeight.w600)
                  .copyWith(color: context.colors.alertError500),
            ),
          ),
        ],
      ),
    );
  }
}

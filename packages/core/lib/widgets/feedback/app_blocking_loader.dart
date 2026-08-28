import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_brand_pulse.dart';

class AppBlockingLoader extends StatelessWidget {
  const AppBlockingLoader({
    super.key,
    required this.logoAsset,
    required this.message,
  });

  final String logoAsset;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      liveRegion: true,
      label: message,
      child: ColoredBox(
        color: context.colors.scrim.withValues(alpha: 0.32),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.shape.screenPadding,
            ),
            child: Material(
              color: context.colors.elementBackground,
              borderRadius: BorderRadius.circular(context.shape.radiusDialog),
              child: Padding(
                padding: EdgeInsets.all(AppDimens.space24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppBrandPulse(logoAsset: logoAsset),
                    SizedBox(height: AppDimens.space24),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: context.styles.bodyMuted(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

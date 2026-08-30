import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/app_entrance_fade.dart';
import 'package:wasel_core/widgets/buttons/app_primary_button.dart';

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.coreL10n;

    final content = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.screenHPadding,
        vertical: AppDimens.space32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppEntranceFade(index: 0, child: _ErrorIllustration()),

          SizedBox(height: AppDimens.space32),

          ExcludeSemantics(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppEntranceFade(
                  index: 1,
                  child: Text(
                    l10n.errorTitle,
                    textAlign: TextAlign.center,
                    style: context.styles.headline(),
                  ),
                ),
                SizedBox(height: AppDimens.space12),
                AppEntranceFade(
                  index: 2,
                  child: Text(
                    l10n.errorBody,
                    textAlign: TextAlign.center,
                    style: context.styles.bodyMuted(),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppDimens.space48),

          AppEntranceFade(
            index: 3,
            child: AppPrimaryButton(
              label: l10n.exitApp,
              onPressed: () async {
                await FlutterExitApp.exitApp();
              },
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: context.colors.screenBackground,
      body: SafeArea(
        child: Semantics(
          container: true,
          liveRegion: true,
          label: '${l10n.errorTitle}. ${l10n.errorBody}',
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (!constraints.hasBoundedHeight) return content;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Center(child: content),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorIllustration extends StatelessWidget {
  const _ErrorIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.space32),
      decoration: BoxDecoration(
        color: context.colors.alertError100,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.warning_amber_rounded,
        size: AppDimens.icon48,
        color: context.colors.alertError500,
      ),
    );
  }
}

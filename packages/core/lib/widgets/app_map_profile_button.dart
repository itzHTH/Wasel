import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';

class AppMapProfileButton extends StatelessWidget {
  const AppMapProfileButton({super.key, required this.onPressed, this.heroTag});

  final VoidCallback onPressed;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: heroTag,
      backgroundColor: context.colors.elementBackground,
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Icon(
        Icons.person_outline,
        size: AppDimens.icon20,
        color: context.colors.primary500,
      ),
    );
  }
}

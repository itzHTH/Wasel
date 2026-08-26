import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// The centered "question? action" line that auth and OTP screens end on.
class AppPromptRow extends StatelessWidget {
  const AppPromptRow({
    super.key,
    required this.message,
    required this.actionLabel,
    this.onTap,
  });

  final String message;

  final String actionLabel;

  /// A null callback renders the action muted and inert.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.styles.bodyMuted(),
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              actionLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: onTap == null
                  ? context.styles.bodyMuted()
                  : context.styles.bodyBrand(),
            ),
          ),
        ),
      ],
    );
  }
}

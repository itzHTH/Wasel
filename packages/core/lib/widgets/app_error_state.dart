import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/app_error_retry.dart';

/// Full-area failure state: a centred AppErrorRetry for when a screen has
/// nothing to show, as opposed to an error beside a field.
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    required this.onRetry,
    this.isRetrying = false,
  });

  final String message;
  final VoidCallback onRetry;
  final bool isRetrying;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.space24),
        child: AppErrorRetry(
          message: message,
          onRetry: onRetry,
          isRetrying: isRetrying,
        ),
      ),
    );
  }
}

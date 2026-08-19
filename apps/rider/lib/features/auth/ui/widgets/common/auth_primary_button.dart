import 'package:flutter/material.dart';
import 'package:wasel_core/widgets/app_primary_button.dart';

/// Auth-flow primary button. Kept as a thin alias over the shared
/// [AppPrimaryButton] so styling stays in one place.
class AuthPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}

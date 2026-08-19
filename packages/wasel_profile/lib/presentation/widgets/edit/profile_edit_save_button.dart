import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wasel_core/widgets/app_primary_button.dart';

/// Save action for the edit form.
class ProfileEditSaveButton extends StatelessWidget {
  const ProfileEditSaveButton({
    super.key,
    required this.isEnabled,
    required this.isSaving,
    required this.onPressed,
  });

  final bool isEnabled;
  final bool isSaving;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: 'حفظ التغييرات',
      isLoading: isSaving,
      onPressed: isEnabled
          ? () {
              HapticFeedback.lightImpact();
              onPressed();
            }
          : null,
    );
  }
}

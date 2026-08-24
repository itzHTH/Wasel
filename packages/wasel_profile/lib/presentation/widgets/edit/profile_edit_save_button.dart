import 'package:flutter/material.dart';
import 'package:wasel_profile/l10n/profile_l10n_extension.dart';
import 'package:flutter/services.dart';
import 'package:wasel_core/widgets/buttons/app_primary_button.dart';

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
      label: context.profileL10n.saveChanges,
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

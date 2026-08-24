import 'package:flutter/material.dart';
import 'package:wasel_profile/l10n/profile_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_inline_error.dart';
import 'package:wasel_core/widgets/cards/app_surface_card.dart';
import 'package:wasel_profile/domain/entities/profile_edit_capabilities.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_avatar_section.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_form.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_locked_note.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_values.dart';

/// The whole edit-profile body, shared by both apps.
class ProfileEditView extends StatelessWidget {
  const ProfileEditView({
    super.key,
    required this.capabilities,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.isSaving,
    required this.onSave,
    this.photoUrl,
    this.saveError,
    this.lockedNote,
  });

  final ProfileEditCapabilities capabilities;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final bool isSaving;

  /// Returns true when the save succeeded.
  final Future<bool> Function(ProfileEditValues values) onSave;

  final String? photoUrl;
  final String? saveError;
  final String? lockedNote;

  @override
  Widget build(BuildContext context) {
    final note =
        lockedNote ??
        (capabilities.canEditName
            ? null
            : context.profileL10n.editPhoneOnlyNotice);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimens.space16,
        AppDimens.space16,
        AppDimens.space16,
        AppDimens.space32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (capabilities.canEditPhoto) ...[
            ProfileEditAvatarSection(
              photoUrl: photoUrl,
              onMessage: (message) => _showMessage(context, message),
            ),
            SizedBox(height: AppDimens.space24),
          ],
          if (note != null) ...[
            ProfileEditLockedNote(message: note),
            SizedBox(height: AppDimens.space16),
          ],
          AppSurfaceCard(
            borderRadius: AppDimens.radius24,
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.space16,
              vertical: AppDimens.space24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ProfileEditForm(
                  capabilities: capabilities,
                  initialFirstName: firstName,
                  initialLastName: lastName,
                  initialPhoneNumber: phoneNumber,
                  isSaving: isSaving,
                  onSave: (values) => _handleSave(context, values),
                ),
                AppInlineError(message: saveError),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave(
    BuildContext context,
    ProfileEditValues values,
  ) async {
    final saved = await onSave(values);
    if (!context.mounted) return;

    // A failure stays on screen and surfaces through [saveError].
    if (!saved) return;

    _showMessage(context, context.profileL10n.profileUpdated);

    // An explicit pop, not `maybePop` — the form's PopScope guards discarding
    // unsaved edits, and there is nothing left to discard at this point.
    Navigator.of(context).pop();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

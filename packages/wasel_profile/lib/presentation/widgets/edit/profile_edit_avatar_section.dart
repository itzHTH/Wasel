import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wasel_profile/l10n/profile_l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/helpers/app_image_picker.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/widgets/avatar/app_editable_avatar.dart';
import 'package:wasel_core/widgets/sheets/app_image_source_sheet.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_photo_upload_provider.dart';

/// Photo picker for the edit form.

class ProfileEditAvatarSection extends ConsumerWidget {
  const ProfileEditAvatarSection({
    super.key,
    required this.photoUrl,
    required this.onMessage,
  });

  final String? photoUrl;
  final void Function(String message) onMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUploading = ref.watch(
      riderPhotoUploadProvider.select((state) => state.isLoading),
    );

    // Report the upload outcome once the request settles.
    ref.listen(riderPhotoUploadProvider, (previous, next) {
      if (previous?.isLoading != true || next.isLoading) return;

      onMessage(
        next.hasError
            ? errorMessageOf(next.error!)
            : context.profileL10n.avatarUpdated,
      );
    });

    return Center(
      child: AppEditableAvatar(
        photoUrl: photoUrl,
        size: 96.r,
        isLoading: isUploading,
        onTap: () => _pickAndUpload(context, ref),
      ),
    );
  }

  Future<void> _pickAndUpload(BuildContext context, WidgetRef ref) async {
    final source = await showAppImageSourceSheet(context: context);
    if (source == null || !context.mounted) return;

    final File? photo;
    try {
      photo = await AppImagePicker.pick(source);
    } on AppImagePickerException catch (e) {
      // The picker takes over the screen; this widget may be gone by the time
      // it returns, so nothing may touch context or ref unguarded.
      if (context.mounted) onMessage(e.message);
      return;
    }

    if (photo == null || !context.mounted) return;

    await ref.read(riderPhotoUploadProvider.notifier).upload(photo);
  }
}

import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_error_state.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_profile/presentation/widgets/profile_placeholders.dart';
import 'package:wasel_profile/domain/entities/profile_edit_capabilities.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_edit_provider.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_view.dart';

/// Driver-side wiring for the shared edit form.
class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(driverProfileControllerProvider);
    final edit = ref.watch(driverProfileEditProvider);

    final isRefreshing = profile.isLoading;

    void refresh() =>
        ref.read(driverProfileControllerProvider.notifier).refresh();

    return Scaffold(
      backgroundColor: context.colors.screenBackground,
      appBar: AppBar(
        title: Text(context.l10n.editProfile),
        backgroundColor: context.colors.screenBackground,
        surfaceTintColor: context.colors.screenBackground,
      ),
      body: profile.when(
        // Keyed apart from the real form so its fields are rebuilt from
        // live values rather than kept from the stand-in.
        loading: () => AppSkeleton(
          child: ProfileEditView(
            key: const ValueKey('skeleton'),
            capabilities: const ProfileEditCapabilities.driver(),
            firstName: placeholderDriverProfile.firstName,
            lastName: placeholderDriverProfile.lastName,
            phoneNumber: placeholderDriverProfile.phoneNumber,
            photoUrl: null,
            isSaving: false,
            saveError: null,
            onSave: (_) async => false,
          ),
        ),
        error: (error, _) => AppErrorState(
          message: errorMessageOf(error),
          onRetry: refresh,
          isRetrying: isRefreshing,
        ),
        data: (profile) => profile == null
            ? AppErrorState(
                message: context.l10n.profileLoadFailed,
                onRetry: refresh,
                isRetrying: isRefreshing,
              )
            : ProfileEditView(
                capabilities: const ProfileEditCapabilities.driver(),
                firstName: profile.firstName,
                lastName: profile.lastName,
                phoneNumber: profile.phoneNumber,
                photoUrl: profile.profilePictureUrl,
                isSaving: edit.isLoading,
                saveError: edit.hasError ? errorMessageOf(edit.error!) : null,
                lockedNote: context.l10n.editPhoneOnlyDriver,
                onSave: (values) => ref
                    .read(driverProfileEditProvider.notifier)
                    .save(phoneNumber: values.phoneNumber),
              ),
      ),
    );
  }
}

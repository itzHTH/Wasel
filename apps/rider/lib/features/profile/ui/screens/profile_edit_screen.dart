import 'package:flutter/material.dart';
import 'package:wasal/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/feedback/app_error_state.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_profile/presentation/widgets/profile_placeholders.dart';
import 'package:wasel_profile/domain/entities/profile_edit_capabilities.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_edit_provider.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';
import 'package:wasel_profile/presentation/widgets/edit/profile_edit_view.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(riderProfileControllerProvider);
    final edit = ref.watch(riderProfileEditProvider);

    final isRefreshing = profile.isLoading;

    void refresh() =>
        ref.read(riderProfileControllerProvider.notifier).refresh();

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
            capabilities: const ProfileEditCapabilities.rider(),
            firstName: placeholderRiderProfile.firstName,
            lastName: placeholderRiderProfile.lastName,
            phoneNumber: placeholderRiderProfile.phoneNumber,
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
                capabilities: const ProfileEditCapabilities.rider(),
                firstName: profile.firstName,
                lastName: profile.lastName,
                phoneNumber: profile.phoneNumber,
                photoUrl: profile.profilePictureUrl,
                isSaving: edit.isLoading,
                saveError: edit.hasError ? errorMessageOf(edit.error!) : null,
                onSave: (values) => ref
                    .read(riderProfileEditProvider.notifier)
                    .save(
                      firstName: values.firstName,
                      lastName: values.lastName,
                      phoneNumber: values.phoneNumber,
                    ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/widgets/app_error_state.dart';
import 'package:wasel_core/widgets/app_loading.dart';
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
      backgroundColor: AppColor.screenBackground,
      appBar: AppBar(
        title: const Text('تعديل الملف الشخصي'),
        backgroundColor: AppColor.screenBackground,
        surfaceTintColor: AppColor.screenBackground,
      ),
      body: profile.when(
        loading: () => const Center(child: AppInlineLoading()),
        error: (error, _) => AppErrorState(
          message: errorMessageOf(error),
          onRetry: refresh,
          isRetrying: isRefreshing,
        ),
        data: (profile) => profile == null
            ? AppErrorState(
                message: 'تعذّر تحميل بيانات الملف الشخصي',
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

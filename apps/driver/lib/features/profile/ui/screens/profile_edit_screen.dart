import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/widgets/app_error_state.dart';
import 'package:wasel_core/widgets/app_loading.dart';
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
                capabilities: const ProfileEditCapabilities.driver(),
                firstName: profile.firstName,
                lastName: profile.lastName,
                phoneNumber: profile.phoneNumber,
                photoUrl: profile.profilePictureUrl,
                isSaving: edit.isLoading,
                saveError: edit.hasError ? errorMessageOf(edit.error!) : null,
                lockedNote:
                    'يمكنك تعديل رقم هاتفك فقط. لتغيير اسمك أو بيانات '
                    'مركبتك تواصل مع الدعم.',
                onSave: (values) => ref
                    .read(driverProfileEditProvider.notifier)
                    .save(phoneNumber: values.phoneNumber),
              ),
      ),
    );
  }
}

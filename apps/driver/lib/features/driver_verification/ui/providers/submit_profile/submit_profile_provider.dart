import 'package:wasel_core/wasel_core.dart';
import 'package:driver/l10n/driver_localizations.dart';
import 'package:driver/features/driver_verification/domain/entities/driver_profile_submission.dart';
import 'package:driver/features/driver_verification/domain/usecases/submit_driver_profile_use_case.dart';
import 'package:driver/features/driver_verification/driver_verification_di_providers.dart';
import 'package:driver/features/driver_verification/ui/providers/submit_profile/submit_profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'submit_profile_provider.g.dart';

@riverpod
class SubmitProfile extends _$SubmitProfile {
  @override
  SubmitProfileState build() => const SubmitUploading(0);

  Future<void> submit(DriverProfileSubmission submission) async {
    state = const SubmitUploading(0);
    final useCase = ref.read(submitDriverProfileUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      SubmitDriverProfileParams(
        submission,
        onProgress: (progress) {
          if (ref.mounted) state = SubmitUploading(progress);
        },
      ),
    );
    if (!ref.mounted) return;

    result.when(
      success: (data) => state = SubmitSuccess(data),
      failure: (error) => state = SubmitFailure(
        errorMessageOf(error, fallback: _l10n.uploadFailed),
      ),
    );
  }
}

/// Localizations for a notifier, which has no BuildContext of its own.
///
/// Reads the active locale directly rather than through the Ref: these are
/// called after long awaits, when the Ref may already be unmounted.
DriverLocalizations get _l10n =>
    lookupDriverLocalizations(AppLocalizationController.currentLocale);

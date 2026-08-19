import 'package:driver/features/driver_verification/domain/entities/driver_profile_submission.dart';
import 'package:driver/features/driver_verification/domain/usecases/submit_driver_profile_use_case.dart';
import 'package:driver/features/driver_verification/ui/providers/driver_verification_use_case.dart';
import 'package:driver/features/driver_verification/ui/providers/submit_profile/submit_profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';

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
        errorMessageOf(error, fallback: 'تعذّر رفع المستندات'),
      ),
    );
  }
}

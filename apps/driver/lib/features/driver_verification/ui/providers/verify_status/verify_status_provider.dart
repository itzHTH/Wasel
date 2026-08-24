import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:driver/features/driver_verification/driver_verification_di_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'verify_status_provider.g.dart';

@riverpod
class VerifyStatus extends _$VerifyStatus {
  @override
  FutureOr<VerificationStatus?> build() {
    return null;
  }

  Future<void> getVerifyStatus() async {
    state = AsyncLoading();
    final useCase = ref.read(getVerificationStatusUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(null);
    if (!ref.mounted) return;

    result.when(
      success: (data) {
        state = AsyncData(data);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );
  }
}

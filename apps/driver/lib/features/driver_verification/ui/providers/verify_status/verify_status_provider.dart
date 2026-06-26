import 'package:dio/dio.dart';
import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:driver/features/driver_verification/ui/providers/driver_verification_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/wasel_core.dart';

part 'verify_status_provider.g.dart';

@riverpod
class VerifyStatusProvider extends _$VerifyStatusProvider {
  @override
  FutureOr<VerificationStatus?> build() {
    return null;
  }

  Future<void> getVerifyStatus() async {
    state = AsyncLoading();
    final useCase = ref.read(getVerificationStatusUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(null);

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

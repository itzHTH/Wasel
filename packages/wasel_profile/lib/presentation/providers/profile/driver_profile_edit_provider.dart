import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_profile/domain/usecases/update_driver_profile_use_case.dart';
import 'package:wasel_profile/presentation/providers/profile/driver_profile_provider.dart';
import 'package:wasel_profile/presentation/providers/profile_di_providers.dart';

part 'driver_profile_edit_provider.g.dart';

@riverpod
class DriverProfileEdit extends _$DriverProfileEdit {
  late UpdateDriverProfileUseCase _useCase;

  @override
  FutureOr<void> build() {
    _useCase = ref.watch(updateDriverProfileUseCaseProvider);
    ref.onDispose(_useCase.cancel);
  }

  Future<bool> save({required String phoneNumber}) async {
    if (state.isLoading) return false;

    state = const AsyncValue.loading();

    // The request has left for the server; keep this provider alive until it
    // answers
    final link = ref.keepAlive();

    final result = await _useCase.call(
      UpdateDriverProfileParams(phoneNumber: phoneNumber),
    );

    try {
      if (!ref.mounted) return false;

      return result.when(
        failure: (error) {
          state = AsyncValue.error(error, StackTrace.current);
          return false;
        },
        success: (_) {
          state = const AsyncValue.data(null);
          ref.invalidate(driverProfileControllerProvider);
          return true;
        },
      );
    } finally {
      link.close();
    }
  }
}

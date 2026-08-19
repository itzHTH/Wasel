import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_profile/domain/usecases/update_rider_profile_use_case.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';
import 'package:wasel_profile/presentation/providers/profile_di_providers.dart';

part 'rider_profile_edit_provider.g.dart';

@riverpod
class RiderProfileEdit extends _$RiderProfileEdit {
  late UpdateRiderProfileUseCase _useCase;

  @override
  FutureOr<void> build() {
    _useCase = ref.watch(updateRiderProfileUseCaseProvider);
    ref.onDispose(_useCase.cancel);
  }

  /// Returns true when the save landed, so the caller can pop the screen.
  Future<bool> save({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    if (state.isLoading) return false;

    state = const AsyncValue.loading();

    // The request has left for the server; keep this provider alive until it
    // answers
    final link = ref.keepAlive();

    final result = await _useCase.call(
      UpdateRiderProfileParams(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
      ),
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
          // Every screen showing the profile picks the change up at once.
          ref.invalidate(riderProfileControllerProvider);
          return true;
        },
      );
    } finally {
      link.close();
    }
  }
}

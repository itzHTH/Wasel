import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'ride_action_controller.g.dart';

@riverpod
class RideActionController extends _$RideActionController {
  @override
  FutureOr<void> build() => null;

  Future<bool> run(Future<ApiResults<void>> Function() action) async {
    // A second tap while the first call is still in flight is a double tap,
    // not a new intent. Dropping it here guards every caller at once.
    if (state.isLoading) return false;

    state = const AsyncValue.loading();

    final ApiResults<void> result;
    try {
      result = await action();
    } catch (error, stackTrace) {
      // Without this the state would stay loading and lock every button.
      if (ref.mounted) state = AsyncError(error, stackTrace);
      return false;
    }

    if (!ref.mounted) return false;

    return result.when(
      success: (_) {
        state = const AsyncValue.data(null);
        return true;
      },
      failure: (error) {
        state = AsyncError(
          error.apiErrorModel.message ?? 'حصل خطأ ما',
          StackTrace.current,
        );
        return false;
      },
    );
  }

  void reportFailure(Object error, StackTrace st) =>
      state = AsyncError(error, st);
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';

part 'ride_action_controller.g.dart';

@riverpod
class RideActionController extends _$RideActionController {
  @override
  FutureOr<void> build() => null;

  Future<bool> run(Future<ApiResults<void>> Function() action) async {
    state = const AsyncValue.loading();
    final result = await action();
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

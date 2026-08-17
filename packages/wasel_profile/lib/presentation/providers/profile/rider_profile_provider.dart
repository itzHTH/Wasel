import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';
import 'package:wasel_profile/presentation/providers/profile_di_providers.dart';

part 'rider_profile_provider.g.dart';

Duration? _noRetry(int retryCount, Object error) => null;

@Riverpod(keepAlive: true, retry: _noRetry)
class RiderProfileController extends _$RiderProfileController {
  @override
  FutureOr<RiderProfile?> build() async {
    final useCase = ref.read(getRiderProfileUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(null);

    return result.when(
      success: (profile) => profile,
      failure: (error) => throw error,
    );
  }

  void refresh() => ref.invalidateSelf();
}

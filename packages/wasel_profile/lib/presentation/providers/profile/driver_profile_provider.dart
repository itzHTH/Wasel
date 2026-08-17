import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/presentation/providers/profile_di_providers.dart';

part 'driver_profile_provider.g.dart';

Duration? _noRetry(int retryCount, Object error) => null;

@Riverpod(keepAlive: true, retry: _noRetry)
class DriverProfileController extends _$DriverProfileController {
  @override
  FutureOr<DriverProfile?> build() async {
    final useCase = ref.read(getDriverProfileUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(null);

    return result.when(
      success: (profile) => profile,
      failure: (error) => throw error,
    );
  }

  void refresh() => ref.invalidateSelf();
}

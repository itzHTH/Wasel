import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_profile/domain/usecases/update_rider_photo_use_case.dart';
import 'package:wasel_profile/presentation/providers/profile/rider_profile_provider.dart';
import 'package:wasel_profile/presentation/providers/profile_di_providers.dart';

part 'rider_photo_upload_provider.g.dart';

@riverpod
class RiderPhotoUpload extends _$RiderPhotoUpload {
  @override
  FutureOr<String?> build() {
    ref.onDispose(ref.read(updateRiderPhotoUseCaseProvider).cancel);
    return null;
  }

  Future<void> upload(File photo, {void Function(double)? onProgress}) async {
    if (state.isLoading) return;

    state = const AsyncValue.loading();

    final useCase = ref.read(updateRiderPhotoUseCaseProvider);

    final result = await useCase.call(
      UpdateRiderPhotoParams(photo: photo, onProgress: onProgress),
    );

    if (!ref.mounted) return;

    result.when(
      failure: (error) => state = AsyncValue.error(error, StackTrace.current),
      success: (photoUrl) {
        state = AsyncValue.data(photoUrl);
        ref.invalidate(riderProfileControllerProvider);
      },
    );
  }
}

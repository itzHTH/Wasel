import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/usecase/cancellable_use_case.dart';
import 'package:wasel_profile/domain/repos/base_profile_repo.dart';

class UpdateRiderPhotoParams {
  final File photo;
  final void Function(double)? onProgress;

  UpdateRiderPhotoParams({required this.photo, this.onProgress});
}

class UpdateRiderPhotoUseCase
    extends CancellableUseCase<ApiResults<String?>, UpdateRiderPhotoParams> {
  final BaseProfileRepo _profileRepo;

  UpdateRiderPhotoUseCase(this._profileRepo);

  @override
  Future<ApiResults<String?>> execute(
    UpdateRiderPhotoParams params,
    CancelToken cancelToken,
  ) {
    return _profileRepo.updateRiderPhoto(
      params.photo,
      onProgress: params.onProgress,
      cancelToken: cancelToken,
    );
  }
}

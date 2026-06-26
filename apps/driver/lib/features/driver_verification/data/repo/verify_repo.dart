import 'package:driver/features/driver_verification/data/services/verify_api_service.dart';
import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:driver/features/driver_verification/domain/repo/base_verify_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

part 'verify_repo.g.dart';

class VerifyRepo implements BaseVerifyRepo {
  final VerifyApiService apiService;

  VerifyRepo(this.apiService);
  @override
  Future<ApiResults<VerificationStatus>> getVerificationStatus() async {
    try {
      final result = await apiService.getVerificationStatus();

      return ApiResults.success(result.toEntity());
    } catch (e) {
      return ApiResults.failure(ErrorHandler.handle(e));
    }
  }
}

@riverpod
VerifyRepo verifyRepo(Ref ref) {
  final verifyApiService = ref.watch(verifyApiServiceProvider);
  return VerifyRepo(verifyApiService);
}

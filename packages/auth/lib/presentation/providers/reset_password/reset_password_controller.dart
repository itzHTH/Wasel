import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/error_message.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';
import 'package:wasel_auth/data/models/reset_password/forgot_password/request/forgot_password_request.dart';
import 'package:wasel_auth/data/models/reset_password/set_new_password/request/reset_password_request.dart';
import 'package:wasel_auth/data/models/reset_password/verify_reset_otp/request/verify_reset_otp_request.dart';
import 'package:wasel_auth/presentation/providers/reset_password/reset_password_state.dart';
import 'package:wasel_auth/providers/auth_use_case_providers.dart';

part 'reset_password_controller.g.dart';

const _fallbackError = 'حصل خطأ ما';
const _expiredError = 'انتهت صلاحية الرمز. يرجى طلب رمز جديد للمتابعة.';

/// Drives the 3-step reset flow and owns the reset token between steps.
///
/// Loading lives in the state rather than an AsyncValue so the token survives
/// an in-flight request. Each step returns whether the caller may advance.
@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  @override
  ResetPasswordState build() => const ResetPasswordState();

  void restart() => state = const ResetPasswordState();

  /// Call when leaving a step so its error does not surface on the next one.
  void clearError() {
    if (state.fieldError == null) return;
    state = state.copyWith(clearFieldError: true);
  }

  Future<bool> requestOtp(String email) async {
    state = state.copyWith(isSubmitting: true, clearFieldError: true);

    final useCase = ref.read(forgotPasswordUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(ForgotPasswordRequest(email: email));

    return result.when(
      failure: (error) {
        state = state.copyWith(
          email: email,
          isSubmitting: false,
          fieldError: _messageFor(error, field: 'Email'),
          tokenExpired: false,
        );
        return false;
      },
      success: (response) {
        state = ResetPasswordState(
          email: email,
          resetToken: response.resetToken,
        );
        return true;
      },
    );
  }

  Future<bool> verifyOtp(String otpCode) async {
    if (state.resetToken.isEmpty) return _markExpired();

    state = state.copyWith(isSubmitting: true, clearFieldError: true);

    final useCase = ref.read(verifyResetOtpUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      VerifyResetOtpRequest(resetToken: state.resetToken, otpCode: otpCode),
    );

    return result.when(
      failure: (error) => _fail(error, field: 'OtpCode'),
      success: (response) {
        state = state.copyWith(
          resetToken: response.resetToken,
          isSubmitting: false,
          clearFieldError: true,
          tokenExpired: false,
        );
        return true;
      },
    );
  }

  Future<bool> setNewPassword(String newPassword) async {
    if (state.resetToken.isEmpty) return _markExpired();

    state = state.copyWith(isSubmitting: true, clearFieldError: true);

    final useCase = ref.read(resetPasswordUseCaseProvider);
    ref.onDispose(useCase.cancel);

    final result = await useCase.call(
      ResetPasswordRequest(token: state.resetToken, newPassword: newPassword),
    );

    return result.when(
      failure: (error) => _fail(error, field: 'NewPassword'),
      success: (response) {
        if (!response.success) {
          state = state.copyWith(
            isSubmitting: false,
            fieldError: _fallbackError,
          );
          return false;
        }
        state = state.copyWith(isSubmitting: false, clearFieldError: true);
        return true;
      },
    );
  }

  bool _markExpired() {
    state = state.copyWith(
      isSubmitting: false,
      fieldError: _expiredError,
      tokenExpired: true,
    );
    return false;
  }

  bool _fail(ErrorHandler error, {required String field}) {
    if (_isExpired(error)) return _markExpired();
    state = state.copyWith(
      isSubmitting: false,
      fieldError: _messageFor(error, field: field),
    );
    return false;
  }

  // The API returns per-field messages under `errors`; prefer them over `message`.
  String _messageFor(ErrorHandler error, {required String field}) {
    final errors = error.apiErrorModel.errors;
    if (errors != null && errors.isNotEmpty) {
      final match = errors.entries.firstWhere(
        (entry) =>
            entry.key.toLowerCase() == field.toLowerCase() &&
            entry.value.isNotEmpty,
        orElse: () => errors.entries.first,
      );
      if (match.value.isNotEmpty) return match.value.first;
    }
    return errorMessageOf(error, fallback: _fallbackError);
  }

  // The reset token and its OTP live in a 10-minute server-side cache. The API
  // may report the expiry either as `message` or inside the `errors` map.
  //
  // TODO: replace this string matching with a stable machine-readable code
  // (e.g. errorCode == 'TOKEN_EXPIRED') once the backend team exposes one.
  // Matching on human-readable text breaks the moment the copy or the
  // Accept-Language header changes, and a miss costs the user the
  // "طلب رمز جديد" recovery action.
  bool _isExpired(ErrorHandler error) {
    final model = error.apiErrorModel;
    final candidates = <String>[
      if (model.message != null) model.message!,
      ...?model.errors?.values.expand((messages) => messages),
    ];
    return candidates.any(_readsAsExpired);
  }

  bool _readsAsExpired(String value) {
    final text = value.toLowerCase();
    return text.contains('expired') ||
        text.contains('invalid token') ||
        text.contains('انتهت') ||
        text.contains('منتهي');
  }
}

class ResetPasswordState {
  final String email;
  final String resetToken;
  final String? fieldError;
  final bool tokenExpired;
  final bool isSubmitting;

  const ResetPasswordState({
    this.email = '',
    this.resetToken = '',
    this.fieldError,
    this.tokenExpired = false,
    this.isSubmitting = false,
  });

  ResetPasswordState copyWith({
    String? email,
    String? resetToken,
    String? fieldError,
    bool clearFieldError = false,
    bool? tokenExpired,
    bool? isSubmitting,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
      fieldError: clearFieldError ? null : (fieldError ?? this.fieldError),
      tokenExpired: tokenExpired ?? this.tokenExpired,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

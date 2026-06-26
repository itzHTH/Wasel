class VerificationStatus {
  final enVerificationStatus status;
  final String message;

  VerificationStatus({required this.status, required this.message});
}

// ignore: camel_case_types
enum enVerificationStatus {
  pending(1),
  underReview(2),
  approved(3),
  rejected(4);

  final int code;
  const enVerificationStatus(this.code);

  static enVerificationStatus fromCode(int code) =>
      enVerificationStatus.values.firstWhere(
        (status) => status.code == code,
        orElse: () => enVerificationStatus.pending,
      );
}

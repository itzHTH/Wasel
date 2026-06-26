enum VerificationStatus {
  pending(1),
  underReview(2),
  approved(3),
  rejected(4);

  final int code;
  const VerificationStatus(this.code);

  static VerificationStatus fromCode(int code) =>
      VerificationStatus.values.firstWhere(
        (status) => status.code == code,
        orElse: () => VerificationStatus.pending,
      );
}

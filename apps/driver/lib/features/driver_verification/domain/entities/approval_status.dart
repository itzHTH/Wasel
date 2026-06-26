class ApprovalStatus {
  final VerificationStatus status;
  final String message;

  ApprovalStatus({required this.status, required this.message});
}

enum VerificationStatus {
  pending(1),
  underReview(2),
  approved(3),
  rejected(4);

  final int code;
  const VerificationStatus(this.code);
}

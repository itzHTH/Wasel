enum DriverApprovalStatus {
  pending(1),
  underReview(2),
  approved(3),
  rejected(4);

  final int code;

  const DriverApprovalStatus(this.code);

  static DriverApprovalStatus fromCode(int code) =>
      DriverApprovalStatus.values.firstWhere(
        (status) => status.code == code,
        orElse: () => DriverApprovalStatus.pending,
      );
}

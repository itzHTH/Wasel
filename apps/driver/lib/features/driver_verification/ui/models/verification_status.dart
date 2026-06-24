/// UI-only verification status, mirroring the back-office codes:
/// `1 = Pending`, `2 = Under Review`, `3 = Approved`, `4 = Rejected`.
///
/// Routing intent: no-status / [rejected] → wizard, [pending] / [underReview] →
/// review screen, [approved] → home. Replaced by the domain entity when the
/// data layer lands (see the `// TODO(provider)` seams).
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

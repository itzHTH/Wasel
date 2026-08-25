class DriverEarnings {
  const DriverEarnings({
    required this.completedRides,
    required this.totalEarnings,
    required this.onlineMinutes,
    required this.canCashOut,
  });

  final int completedRides;
  final num totalEarnings;
  final num onlineMinutes;
  final bool canCashOut;
}

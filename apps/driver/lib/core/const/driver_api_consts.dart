class DriverApiConsts {
  static const String getVerificationStatus = "/api/v1/driver-profile/status";
  static const String submitDriverProfile = "/api/v1/driver-profile/submit";

  static const String acceptRide = "/api/v1/Rides/{id}/accept";
  static const String arriveAtStartPoint = "/api/v1/Rides/{id}/arrive";
  static const String startRide = "/api/v1/Rides/{id}/start";
  static const String completeRide = "/api/v1/Rides/{id}/complete";
  static const String driverCancelRide = "/api/v1/Rides/{id}/driver-cancel";

  static const String getDriverWalletBalance = "/api/v1/wallet/driver/balance";
  static const String getDriverEarnings = "/api/v1/DriverEarnings/overview";

  static const String googleReverseGeocoding = "/geocode/location/{lat},{lng}";
}

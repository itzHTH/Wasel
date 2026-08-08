/// The rider a driver is currently serving.
///
/// The backend has no endpoint for this yet, so the app serves a placeholder
/// instance and [isPlaceholder] drives the «تجريبي» tag on the UI. When the
/// endpoint lands, only the provider changes — this contract stays.
class RiderProfile {
  const RiderProfile({
    required this.name,
    this.photoUrl,
    this.rating,
    this.totalTrips,
    this.phoneNumber,
    this.isPlaceholder = false,
  });

  final String name;
  final String? photoUrl;
  final double? rating;
  final int? totalTrips;
  final String? phoneNumber;
  final bool isPlaceholder;

  @override
  bool operator ==(Object other) =>
      other is RiderProfile &&
      other.name == name &&
      other.photoUrl == photoUrl &&
      other.rating == rating &&
      other.totalTrips == totalTrips &&
      other.phoneNumber == phoneNumber &&
      other.isPlaceholder == isPlaceholder;

  @override
  int get hashCode => Object.hash(
    name,
    photoUrl,
    rating,
    totalTrips,
    phoneNumber,
    isPlaceholder,
  );
}

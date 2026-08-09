/// The rider a driver is currently serving.
///
/// [name] and [phoneNumber] come from the ride offer event. The rest has no
/// backend source yet and stays null until an endpoint exposes it — this
/// contract does not change when it lands.
class RiderProfile {
  const RiderProfile({
    required this.name,
    this.photoUrl,
    this.totalTrips,
    this.phoneNumber,
  });

  final String name;
  final String? photoUrl;
  final int? totalTrips;
  final String? phoneNumber;

  @override
  bool operator ==(Object other) =>
      other is RiderProfile &&
      other.name == name &&
      other.photoUrl == photoUrl &&
      other.totalTrips == totalTrips &&
      other.phoneNumber == phoneNumber;

  @override
  int get hashCode => Object.hash(name, photoUrl, totalTrips, phoneNumber);
}

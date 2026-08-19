class DriverProfile {
  final String id;
  final String name;

  final String? phoneNumber;
  final String? photoUrl;
  final String? plateNumber;
  final String? carModel;
  final String? carColor;
  final String? vehicleYear;

  DriverProfile({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.photoUrl,
    this.plateNumber,
    this.carModel,
    this.carColor,
    this.vehicleYear,
  });

  String? get vehicleLabel {
    final parts = [
      carModel,
      carColor,
      vehicleYear,
    ].where((p) => p != null && p.isNotEmpty).cast<String>();
    return parts.isEmpty ? null : parts.join(' • ');
  }

  bool get canBeContacted => phoneNumber != null && phoneNumber!.isNotEmpty;
}

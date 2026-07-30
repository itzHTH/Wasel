class DriverProfile {
  final String id;
  final String name;

  final String? phoneNumber;
  final String? photoUrl;
  final String? plateNumber;
  final String? carModel;
  final String? carColor;

  DriverProfile({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.photoUrl,
    this.plateNumber,
    this.carModel,
    this.carColor,
  });

  String? get vehicleLabel {
    final parts = [
      carModel,
      carColor,
    ].where((p) => p != null && p.isNotEmpty).cast<String>();
    return parts.isEmpty ? null : parts.join(' • ');
  }

  bool get canBeContacted => phoneNumber != null && phoneNumber!.isNotEmpty;
}

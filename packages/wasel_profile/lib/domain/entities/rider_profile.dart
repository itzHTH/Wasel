class RiderProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profilePictureUrl;
  final double balance;

  RiderProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePictureUrl,
    required this.balance,
  });

  String get fullName => '$firstName $lastName'.trim();
}

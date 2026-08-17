import 'package:wasel_profile/domain/entities/driver_approval_status.dart';

class DriverProfile {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? profilePictureUrl;
  final double averageRating;
  final int totalReviews;
  final DriverApprovalStatus approvalStatus;
  final String? city;
  final String? address;
  final double balance;

  DriverProfile({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePictureUrl,
    required this.averageRating,
    required this.totalReviews,
    required this.approvalStatus,
    this.city,
    this.address,
    required this.balance,
  });

  String get fullName => '$firstName $lastName'.trim();
}

import 'package:wasel_profile/domain/entities/driver_approval_status.dart';
import 'package:wasel_profile/domain/entities/driver_profile.dart';
import 'package:wasel_profile/domain/entities/rider_profile.dart';

/// Stand-in profiles the skeleton lays out while the real one loads. Shared so
/// every profile surface shimmers the same shape.
final placeholderRiderProfile = RiderProfile(
  firstName: 'محمد',
  lastName: 'العبيدي',
  email: 'name@example.com',
  phoneNumber: '07700000000',
  balance: 87512,
);

final placeholderDriverProfile = DriverProfile(
  firstName: 'محمد',
  lastName: 'العبيدي',
  email: 'name@example.com',
  phoneNumber: '07700000000',
  averageRating: 4.9,
  totalReviews: 123,
  approvalStatus: DriverApprovalStatus.approved,
  city: 'بغداد',
  address: 'حي الحمداني',
  balance: 87512,
);

class ProfileEditCapabilities {
  final bool canEditFirstName;
  final bool canEditLastName;
  final bool canEditPhoneNumber;
  final bool canEditPhoto;

  const ProfileEditCapabilities({
    required this.canEditFirstName,
    required this.canEditLastName,
    required this.canEditPhoneNumber,
    required this.canEditPhoto,
  });

  const ProfileEditCapabilities.rider()
    : canEditFirstName = true,
      canEditLastName = true,
      canEditPhoneNumber = true,
      canEditPhoto = true;

  const ProfileEditCapabilities.driver()
    : canEditFirstName = false,
      canEditLastName = false,
      canEditPhoneNumber = true,
      canEditPhoto = false;

  bool get canEditName => canEditFirstName || canEditLastName;
}

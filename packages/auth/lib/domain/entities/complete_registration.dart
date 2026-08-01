class CompleteRegistration {
  final bool isAuthenticated;
  final String? userName;
  final String email;

  CompleteRegistration({
    required this.isAuthenticated,
    this.userName,
    required this.email,
  });
}

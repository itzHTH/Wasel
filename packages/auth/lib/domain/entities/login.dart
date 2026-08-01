class Login {
  final bool isAuthenticated;
  final String? userName;
  final String email;

  Login({
    required this.isAuthenticated,
    this.userName,
    required this.email,
  });
}

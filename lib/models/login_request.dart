class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password, required String email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': username,
      'password': password,
    };
  }
}

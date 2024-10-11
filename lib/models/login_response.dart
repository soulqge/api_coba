class LoginResponse {
  final String token;
  final String userId;
  final String userName;

  LoginResponse({
    required this.token,
    required this.userId,
    required this.userName,
  });

  // Factory method to create LoginResponse from JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      userId: json['userId'],
      userName: json['userName'],
    );
  }
}

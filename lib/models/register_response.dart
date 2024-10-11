class RegisterResponse {
  final String message;
  final String userId;

  RegisterResponse({
    required this.message,
    required this.userId,
  });

  // Factory method to create a RegisterResponse from JSON
  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'],
      userId: json['userId'],
    );
  }
}
